// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aid_types_dao.dart';

// ignore_for_file: type=lint
mixin _$AidTypesDaoMixin on DatabaseAccessor<AppDatabase> {
  $AidTypesTable get aidTypes => attachedDatabase.aidTypes;
  $CampaignsTable get campaigns => attachedDatabase.campaigns;
  AidTypesDaoManager get managers => AidTypesDaoManager(this);
}

class AidTypesDaoManager {
  final _$AidTypesDaoMixin _db;
  AidTypesDaoManager(this._db);
  $$AidTypesTableTableManager get aidTypes =>
      $$AidTypesTableTableManager(_db.attachedDatabase, _db.aidTypes);
  $$CampaignsTableTableManager get campaigns =>
      $$CampaignsTableTableManager(_db.attachedDatabase, _db.campaigns);
}
