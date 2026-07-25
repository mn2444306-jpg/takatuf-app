import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/campaigns_dao.dart';
import '../../domain/repositories/campaigns_repository.dart';

class CampaignsRepositoryImpl implements CampaignsRepository {
  CampaignsRepositoryImpl(this._dao);

  final CampaignsDao _dao;

  @override
  Stream<List<CampaignSummary>> watchAllSummaries() =>
      _dao.watchAllSummaries();

  @override
  Stream<(Campaign, AidType?)> watchCampaignWithAidType(int campaignId) =>
      _dao.watchCampaignWithAidType(campaignId);

  @override
  Future<List<Village>> getCampaignVillages(int campaignId) =>
      _dao.getCampaignVillages(campaignId);

  @override
  Future<List<ResidencePlace>> getCampaignResidencePlaces(int campaignId) =>
      _dao.getCampaignResidencePlaces(campaignId);

  @override
  Stream<List<(CampaignBeneficiary, Beneficiary)>> watchCampaignBeneficiaries(
    int campaignId,
  ) => _dao.watchCampaignBeneficiaries(campaignId);

  @override
  Future<int> previewMatchingCount({
    required String beneficiaryType,
    required List<int> villageIds,
    required List<int> residencePlaceIds,
  }) => _dao.previewMatchingCount(
    beneficiaryType: beneficiaryType,
    villageIds: villageIds,
    residencePlaceIds: residencePlaceIds,
  );

  @override
  Future<int> createCampaign({
    required String name,
    required String beneficiaryType,
    int? aidTypeId,
    double? amountPerBeneficiary,
    String? notes,
    required List<int> villageIds,
    required List<int> residencePlaceIds,
  }) => _dao.createCampaign(
    campaign: CampaignsCompanion.insert(
      name: name,
      beneficiaryType: beneficiaryType,
      aidTypeId: Value(aidTypeId),
      amountPerBeneficiary: Value(amountPerBeneficiary),
      notes: Value(notes),
    ),
    villageIds: villageIds,
    residencePlaceIds: residencePlaceIds,
  );

  @override
  Future<void> setReceived(int campaignBeneficiaryId, bool received) =>
      _dao.setReceived(campaignBeneficiaryId, received);
}
