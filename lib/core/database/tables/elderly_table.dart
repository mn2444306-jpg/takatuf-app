import 'package:drift/drift.dart';

import 'beneficiaries_table.dart';

@DataClassName('ElderlyBeneficiary')
class Elderly extends Table {
  IntColumn get beneficiaryId => integer()
      .references(Beneficiaries, #id, onDelete: KeyAction.cascade)();
  IntColumn get age => integer()();

  @override
  Set<Column> get primaryKey => {beneficiaryId};
}
