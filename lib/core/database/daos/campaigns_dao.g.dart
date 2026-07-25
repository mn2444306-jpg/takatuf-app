// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaigns_dao.dart';

// ignore_for_file: type=lint
mixin _$CampaignsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AidTypesTable get aidTypes => attachedDatabase.aidTypes;
  $CampaignsTable get campaigns => attachedDatabase.campaigns;
  $VillagesTable get villages => attachedDatabase.villages;
  $ResidencePlacesTable get residencePlaces => attachedDatabase.residencePlaces;
  $BeneficiariesTable get beneficiaries => attachedDatabase.beneficiaries;
  $CampaignBeneficiariesTable get campaignBeneficiaries =>
      attachedDatabase.campaignBeneficiaries;
  $CampaignVillagesTable get campaignVillages =>
      attachedDatabase.campaignVillages;
  $CampaignResidencePlacesTable get campaignResidencePlaces =>
      attachedDatabase.campaignResidencePlaces;
  $StudentsTable get students => attachedDatabase.students;
  $ElderlyTable get elderly => attachedDatabase.elderly;
  $MarriedTable get married => attachedDatabase.married;
  CampaignsDaoManager get managers => CampaignsDaoManager(this);
}

class CampaignsDaoManager {
  final _$CampaignsDaoMixin _db;
  CampaignsDaoManager(this._db);
  $$AidTypesTableTableManager get aidTypes =>
      $$AidTypesTableTableManager(_db.attachedDatabase, _db.aidTypes);
  $$CampaignsTableTableManager get campaigns =>
      $$CampaignsTableTableManager(_db.attachedDatabase, _db.campaigns);
  $$VillagesTableTableManager get villages =>
      $$VillagesTableTableManager(_db.attachedDatabase, _db.villages);
  $$ResidencePlacesTableTableManager get residencePlaces =>
      $$ResidencePlacesTableTableManager(
        _db.attachedDatabase,
        _db.residencePlaces,
      );
  $$BeneficiariesTableTableManager get beneficiaries =>
      $$BeneficiariesTableTableManager(_db.attachedDatabase, _db.beneficiaries);
  $$CampaignBeneficiariesTableTableManager get campaignBeneficiaries =>
      $$CampaignBeneficiariesTableTableManager(
        _db.attachedDatabase,
        _db.campaignBeneficiaries,
      );
  $$CampaignVillagesTableTableManager get campaignVillages =>
      $$CampaignVillagesTableTableManager(
        _db.attachedDatabase,
        _db.campaignVillages,
      );
  $$CampaignResidencePlacesTableTableManager get campaignResidencePlaces =>
      $$CampaignResidencePlacesTableTableManager(
        _db.attachedDatabase,
        _db.campaignResidencePlaces,
      );
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db.attachedDatabase, _db.students);
  $$ElderlyTableTableManager get elderly =>
      $$ElderlyTableTableManager(_db.attachedDatabase, _db.elderly);
  $$MarriedTableTableManager get married =>
      $$MarriedTableTableManager(_db.attachedDatabase, _db.married);
}
