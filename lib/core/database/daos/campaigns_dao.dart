import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/aid_types_table.dart';
import '../tables/beneficiaries_table.dart';
import '../tables/campaign_beneficiaries_table.dart';
import '../tables/campaign_residence_places_table.dart';
import '../tables/campaign_villages_table.dart';
import '../tables/campaigns_table.dart';
import '../tables/residence_places_table.dart';
import '../tables/villages_table.dart';

part 'campaigns_dao.g.dart';

typedef CampaignSummary = ({
  Campaign campaign,
  AidType aidType,
  int total,
  int received,
});

@DriftAccessor(
  tables: [
    Campaigns,
    CampaignBeneficiaries,
    CampaignVillages,
    CampaignResidencePlaces,
    Beneficiaries,
    AidTypes,
    Villages,
    ResidencePlaces,
  ],
)
class CampaignsDao extends DatabaseAccessor<AppDatabase>
    with _$CampaignsDaoMixin {
  CampaignsDao(super.db);

  Stream<List<CampaignSummary>> watchAllSummaries() {
    final totalCount = campaignBeneficiaries.id.count();
    final receivedCount = campaignBeneficiaries.id.count(
      filter: campaignBeneficiaries.status.equals('received'),
    );
    final query = select(campaigns).join([
      innerJoin(aidTypes, aidTypes.id.equalsExp(campaigns.aidTypeId)),
      leftOuterJoin(
        campaignBeneficiaries,
        campaignBeneficiaries.campaignId.equalsExp(campaigns.id),
      ),
    ])
      ..addColumns([totalCount, receivedCount])
      ..groupBy([campaigns.id])
      ..orderBy([
        OrderingTerm(expression: campaigns.createdAt, mode: OrderingMode.desc),
      ]);
    return query.watch().map(
          (rows) => rows
              .map(
                (row) => (
                  campaign: row.readTable(campaigns),
                  aidType: row.readTable(aidTypes),
                  total: row.read(totalCount) ?? 0,
                  received: row.read(receivedCount) ?? 0,
                ),
              )
              .toList(),
        );
  }

  Stream<(Campaign, AidType)> watchCampaignWithAidType(int campaignId) {
    final query = select(campaigns).join([
      innerJoin(aidTypes, aidTypes.id.equalsExp(campaigns.aidTypeId)),
    ])
      ..where(campaigns.id.equals(campaignId));
    return query.watchSingle().map(
          (row) => (row.readTable(campaigns), row.readTable(aidTypes)),
        );
  }

  Future<List<Village>> getCampaignVillages(int campaignId) {
    final query = select(villages).join([
      innerJoin(
        campaignVillages,
        campaignVillages.villageId.equalsExp(villages.id),
      ),
    ])
      ..where(campaignVillages.campaignId.equals(campaignId))
      ..orderBy([OrderingTerm(expression: villages.name)]);
    return query.map((row) => row.readTable(villages)).get();
  }

  Future<List<ResidencePlace>> getCampaignResidencePlaces(int campaignId) {
    final query = select(residencePlaces).join([
      innerJoin(
        campaignResidencePlaces,
        campaignResidencePlaces.residencePlaceId.equalsExp(
          residencePlaces.id,
        ),
      ),
    ])
      ..where(campaignResidencePlaces.campaignId.equals(campaignId))
      ..orderBy([OrderingTerm(expression: residencePlaces.name)]);
    return query.map((row) => row.readTable(residencePlaces)).get();
  }

  Stream<List<(CampaignBeneficiary, Beneficiary)>> watchCampaignBeneficiaries(
    int campaignId,
  ) {
    final query = select(campaignBeneficiaries).join([
      innerJoin(
        beneficiaries,
        beneficiaries.id.equalsExp(campaignBeneficiaries.beneficiaryId),
      ),
    ])
      ..where(campaignBeneficiaries.campaignId.equals(campaignId))
      ..orderBy([OrderingTerm(expression: beneficiaries.primaryName)]);
    return query.watch().map(
          (rows) => rows
              .map(
                (row) => (
                  row.readTable(campaignBeneficiaries),
                  row.readTable(beneficiaries),
                ),
              )
              .toList(),
        );
  }

  Future<int> previewMatchingCount({
    required String beneficiaryType,
    required List<int> villageIds,
    required List<int> residencePlaceIds,
  }) async {
    if (villageIds.isEmpty || residencePlaceIds.isEmpty) return 0;
    final count = await (selectOnly(beneficiaries)
          ..addColumns([beneficiaries.id.count()])
          ..where(
            beneficiaries.beneficiaryType.equals(beneficiaryType) &
                beneficiaries.isActive.equals(true) &
                beneficiaries.villageId.isIn(villageIds) &
                beneficiaries.residencePlaceId.isIn(residencePlaceIds),
          ))
        .map((row) => row.read(beneficiaries.id.count()) ?? 0)
        .getSingle();
    return count;
  }

  Future<int> createCampaign({
    required CampaignsCompanion campaign,
    required List<int> villageIds,
    required List<int> residencePlaceIds,
  }) {
    return transaction(() async {
      final campaignId = await into(campaigns).insert(campaign);

      await batch((batch) {
        batch.insertAll(campaignVillages, [
          for (final villageId in villageIds)
            CampaignVillagesCompanion.insert(
              campaignId: campaignId,
              villageId: villageId,
            ),
        ]);
        batch.insertAll(campaignResidencePlaces, [
          for (final residencePlaceId in residencePlaceIds)
            CampaignResidencePlacesCompanion.insert(
              campaignId: campaignId,
              residencePlaceId: residencePlaceId,
            ),
        ]);
      });

      final createdCampaign = await (select(
        campaigns,
      )..where((t) => t.id.equals(campaignId))).getSingle();

      final matchingIds = villageIds.isEmpty || residencePlaceIds.isEmpty
          ? <int>[]
          : await (selectOnly(beneficiaries)
                  ..addColumns([beneficiaries.id])
                  ..where(
                    beneficiaries.beneficiaryType.equals(
                          createdCampaign.beneficiaryType,
                        ) &
                        beneficiaries.isActive.equals(true) &
                        beneficiaries.villageId.isIn(villageIds) &
                        beneficiaries.residencePlaceId.isIn(
                          residencePlaceIds,
                        ),
                  ))
                .map((row) => row.read(beneficiaries.id)!)
                .get();

      if (matchingIds.isNotEmpty) {
        await batch((batch) {
          batch.insertAll(campaignBeneficiaries, [
            for (final beneficiaryId in matchingIds)
              CampaignBeneficiariesCompanion.insert(
                campaignId: campaignId,
                beneficiaryId: beneficiaryId,
                amount: Value(createdCampaign.amountPerBeneficiary),
              ),
          ]);
        });
      }

      return campaignId;
    });
  }

  Future<void> setReceived(int campaignBeneficiaryId, bool received) {
    return (update(
      campaignBeneficiaries,
    )..where((t) => t.id.equals(campaignBeneficiaryId))).write(
      CampaignBeneficiariesCompanion(
        status: Value(received ? 'received' : 'pending'),
        receivedAt: Value(received ? DateTime.now() : null),
      ),
    );
  }
}
