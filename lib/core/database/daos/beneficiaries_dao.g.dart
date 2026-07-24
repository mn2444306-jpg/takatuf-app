// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiaries_dao.dart';

// ignore_for_file: type=lint
mixin _$BeneficiariesDaoMixin on DatabaseAccessor<AppDatabase> {
  $VillagesTable get villages => attachedDatabase.villages;
  $ResidencePlacesTable get residencePlaces => attachedDatabase.residencePlaces;
  $BeneficiariesTable get beneficiaries => attachedDatabase.beneficiaries;
  $HouseholdsTable get households => attachedDatabase.households;
  $StudentsTable get students => attachedDatabase.students;
  $ElderlyTable get elderly => attachedDatabase.elderly;
  $MarriedTable get married => attachedDatabase.married;
  BeneficiariesDaoManager get managers => BeneficiariesDaoManager(this);
}

class BeneficiariesDaoManager {
  final _$BeneficiariesDaoMixin _db;
  BeneficiariesDaoManager(this._db);
  $$VillagesTableTableManager get villages =>
      $$VillagesTableTableManager(_db.attachedDatabase, _db.villages);
  $$ResidencePlacesTableTableManager get residencePlaces =>
      $$ResidencePlacesTableTableManager(
        _db.attachedDatabase,
        _db.residencePlaces,
      );
  $$BeneficiariesTableTableManager get beneficiaries =>
      $$BeneficiariesTableTableManager(_db.attachedDatabase, _db.beneficiaries);
  $$HouseholdsTableTableManager get households =>
      $$HouseholdsTableTableManager(_db.attachedDatabase, _db.households);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db.attachedDatabase, _db.students);
  $$ElderlyTableTableManager get elderly =>
      $$ElderlyTableTableManager(_db.attachedDatabase, _db.elderly);
  $$MarriedTableTableManager get married =>
      $$MarriedTableTableManager(_db.attachedDatabase, _db.married);
}
