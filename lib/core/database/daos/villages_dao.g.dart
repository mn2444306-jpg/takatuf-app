// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'villages_dao.dart';

// ignore_for_file: type=lint
mixin _$VillagesDaoMixin on DatabaseAccessor<AppDatabase> {
  $VillagesTable get villages => attachedDatabase.villages;
  $ResidencePlacesTable get residencePlaces => attachedDatabase.residencePlaces;
  $BeneficiariesTable get beneficiaries => attachedDatabase.beneficiaries;
  $AidTypesTable get aidTypes => attachedDatabase.aidTypes;
  $CampaignsTable get campaigns => attachedDatabase.campaigns;
  $CampaignVillagesTable get campaignVillages =>
      attachedDatabase.campaignVillages;
  VillagesDaoManager get managers => VillagesDaoManager(this);
}

class VillagesDaoManager {
  final _$VillagesDaoMixin _db;
  VillagesDaoManager(this._db);
  $$VillagesTableTableManager get villages =>
      $$VillagesTableTableManager(_db.attachedDatabase, _db.villages);
  $$ResidencePlacesTableTableManager get residencePlaces =>
      $$ResidencePlacesTableTableManager(
        _db.attachedDatabase,
        _db.residencePlaces,
      );
  $$BeneficiariesTableTableManager get beneficiaries =>
      $$BeneficiariesTableTableManager(_db.attachedDatabase, _db.beneficiaries);
  $$AidTypesTableTableManager get aidTypes =>
      $$AidTypesTableTableManager(_db.attachedDatabase, _db.aidTypes);
  $$CampaignsTableTableManager get campaigns =>
      $$CampaignsTableTableManager(_db.attachedDatabase, _db.campaigns);
  $$CampaignVillagesTableTableManager get campaignVillages =>
      $$CampaignVillagesTableTableManager(
        _db.attachedDatabase,
        _db.campaignVillages,
      );
}
