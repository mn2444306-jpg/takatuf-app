import 'package:drift/drift.dart';

import 'residence_places_table.dart';
import 'villages_table.dart';

@DataClassName('Beneficiary')
class Beneficiaries extends Table {
  IntColumn get id => integer().autoIncrement()();
  // 'household' | 'student' | 'elderly' | 'married' — راجع BeneficiaryType
  TextColumn get beneficiaryType => text()();
  TextColumn get primaryName => text().withLength(min: 1, max: 150)();
  IntColumn get villageId => integer().references(Villages, #id)();
  IntColumn get residencePlaceId =>
      integer().references(ResidencePlaces, #id)();
  TextColumn get phone => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
