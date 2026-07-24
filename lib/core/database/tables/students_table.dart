import 'package:drift/drift.dart';

import 'beneficiaries_table.dart';

@DataClassName('Student')
class Students extends Table {
  IntColumn get beneficiaryId => integer()
      .references(Beneficiaries, #id, onDelete: KeyAction.cascade)();
  TextColumn get schoolName => text()();
  TextColumn get educationStage => text()();
  TextColumn get classGrade => text()();

  @override
  Set<Column> get primaryKey => {beneficiaryId};
}
