import 'package:drift/drift.dart';

import 'beneficiaries_table.dart';

@DataClassName('ElderlyBeneficiary')
class Elderly extends Table {
  IntColumn get beneficiaryId => integer()
      .references(Beneficiaries, #id, onDelete: KeyAction.cascade)();
  RealColumn get allocatedAmount => real().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {beneficiaryId};
}
