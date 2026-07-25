import 'package:drift/drift.dart';

import 'aid_types_table.dart';

@DataClassName('Campaign')
class Campaigns extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  // 'household' | 'student' | 'elderly' | 'married' — راجع BeneficiaryType
  TextColumn get beneficiaryType => text()();
  IntColumn get aidTypeId => integer().nullable().references(AidTypes, #id)();
  RealColumn get amountPerBeneficiary => real().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
