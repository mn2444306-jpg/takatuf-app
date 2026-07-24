import 'package:drift/drift.dart';

import 'beneficiaries_table.dart';

@DataClassName('MarriedBeneficiary')
class Married extends Table {
  IntColumn get beneficiaryId => integer()
      .references(Beneficiaries, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get marriageDate => dateTime()();

  @override
  Set<Column> get primaryKey => {beneficiaryId};
}
