import 'package:drift/drift.dart';

import 'beneficiaries_table.dart';

@DataClassName('Household')
class Households extends Table {
  IntColumn get beneficiaryId => integer()
      .references(Beneficiaries, #id, onDelete: KeyAction.cascade)();
  TextColumn get wifeName => text().nullable()();
  IntColumn get familyMembersCount =>
      integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {beneficiaryId};
}
