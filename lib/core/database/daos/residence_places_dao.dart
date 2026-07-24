import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/beneficiaries_table.dart';
import '../tables/campaign_residence_places_table.dart';
import '../tables/residence_places_table.dart';

part 'residence_places_dao.g.dart';

@DriftAccessor(tables: [ResidencePlaces, Beneficiaries, CampaignResidencePlaces])
class ResidencePlacesDao extends DatabaseAccessor<AppDatabase>
    with _$ResidencePlacesDaoMixin {
  ResidencePlacesDao(super.db);

  Stream<List<ResidencePlace>> watchAll() =>
      (select(residencePlaces)
            ..orderBy([(t) => OrderingTerm(expression: t.name)]))
          .watch();

  Future<int> insertOne(ResidencePlacesCompanion entry) =>
      into(residencePlaces).insert(entry);

  Future<bool> updateOne(ResidencePlace entry) =>
      update(residencePlaces).replace(entry);

  Future<int> deleteOne(int id) =>
      (delete(residencePlaces)..where((t) => t.id.equals(id))).go();

  Future<bool> isInUse(int residencePlaceId) async {
    final beneficiaryCount = await (selectOnly(beneficiaries)
          ..addColumns([beneficiaries.id.count()])
          ..where(beneficiaries.residencePlaceId.equals(residencePlaceId)))
        .map((row) => row.read(beneficiaries.id.count()) ?? 0)
        .getSingle();
    if (beneficiaryCount > 0) return true;

    final campaignCount = await (selectOnly(campaignResidencePlaces)
          ..addColumns([campaignResidencePlaces.residencePlaceId.count()])
          ..where(campaignResidencePlaces.residencePlaceId
              .equals(residencePlaceId)))
        .map(
          (row) => row.read(campaignResidencePlaces.residencePlaceId.count()) ?? 0,
        )
        .getSingle();
    return campaignCount > 0;
  }
}
