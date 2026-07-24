// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'residence_places_dao.dart';

// ignore_for_file: type=lint
mixin _$ResidencePlacesDaoMixin on DatabaseAccessor<AppDatabase> {
  $ResidencePlacesTable get residencePlaces => attachedDatabase.residencePlaces;
  $VillagesTable get villages => attachedDatabase.villages;
  $BeneficiariesTable get beneficiaries => attachedDatabase.beneficiaries;
  $AidTypesTable get aidTypes => attachedDatabase.aidTypes;
  $CampaignsTable get campaigns => attachedDatabase.campaigns;
  $CampaignResidencePlacesTable get campaignResidencePlaces =>
      attachedDatabase.campaignResidencePlaces;
  ResidencePlacesDaoManager get managers => ResidencePlacesDaoManager(this);
}

class ResidencePlacesDaoManager {
  final _$ResidencePlacesDaoMixin _db;
  ResidencePlacesDaoManager(this._db);
  $$ResidencePlacesTableTableManager get residencePlaces =>
      $$ResidencePlacesTableTableManager(
        _db.attachedDatabase,
        _db.residencePlaces,
      );
  $$VillagesTableTableManager get villages =>
      $$VillagesTableTableManager(_db.attachedDatabase, _db.villages);
  $$BeneficiariesTableTableManager get beneficiaries =>
      $$BeneficiariesTableTableManager(_db.attachedDatabase, _db.beneficiaries);
  $$AidTypesTableTableManager get aidTypes =>
      $$AidTypesTableTableManager(_db.attachedDatabase, _db.aidTypes);
  $$CampaignsTableTableManager get campaigns =>
      $$CampaignsTableTableManager(_db.attachedDatabase, _db.campaigns);
  $$CampaignResidencePlacesTableTableManager get campaignResidencePlaces =>
      $$CampaignResidencePlacesTableTableManager(
        _db.attachedDatabase,
        _db.campaignResidencePlaces,
      );
}
