import 'package:drift/drift.dart';

import 'beneficiaries_table.dart';

@DataClassName('Student')
class Students extends Table {
  IntColumn get beneficiaryId => integer()
      .references(Beneficiaries, #id, onDelete: KeyAction.cascade)();
  TextColumn get universityName => text().nullable()();
  RealColumn get allocatedAmount => real().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {beneficiaryId};
}
