import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/campaigns_dao.dart';

abstract class CampaignsRepository {
  Stream<List<CampaignSummary>> watchAllSummaries();

  Stream<(Campaign, AidType)> watchCampaignWithAidType(int campaignId);

  Future<List<Village>> getCampaignVillages(int campaignId);

  Future<List<ResidencePlace>> getCampaignResidencePlaces(int campaignId);

  Stream<List<(CampaignBeneficiary, Beneficiary)>> watchCampaignBeneficiaries(
    int campaignId,
  );

  Future<int> previewMatchingCount({
    required String beneficiaryType,
    required List<int> villageIds,
    required List<int> residencePlaceIds,
  });

  Future<int> createCampaign({
    required String name,
    required String beneficiaryType,
    required int aidTypeId,
    double? amountPerBeneficiary,
    String? notes,
    required List<int> villageIds,
    required List<int> residencePlaceIds,
  });

  Future<void> setReceived(int campaignBeneficiaryId, bool received);
}
