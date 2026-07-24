import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/beneficiaries_table.dart';
import '../tables/elderly_table.dart';
import '../tables/households_table.dart';
import '../tables/married_table.dart';
import '../tables/students_table.dart';

part 'beneficiaries_dao.g.dart';

@DriftAccessor(
  tables: [Beneficiaries, Households, Students, Elderly, Married],
)
class BeneficiariesDao extends DatabaseAccessor<AppDatabase>
    with _$BeneficiariesDaoMixin {
  BeneficiariesDao(super.db);

  static const _householdType = 'household';
  static const _studentType = 'student';
  static const _elderlyType = 'elderly';
  static const _marriedType = 'married';

  Stream<List<(Beneficiary, Household)>> watchHouseholds() {
    final query = select(beneficiaries).join([
      innerJoin(households, households.beneficiaryId.equalsExp(beneficiaries.id)),
    ])
      ..where(beneficiaries.beneficiaryType.equals(_householdType))
      ..orderBy([OrderingTerm(expression: beneficiaries.primaryName)]);
    return query.watch().map(
          (rows) => rows
              .map((row) => (row.readTable(beneficiaries), row.readTable(households)))
              .toList(),
        );
  }

  Stream<List<(Beneficiary, Student)>> watchStudents() {
    final query = select(beneficiaries).join([
      innerJoin(students, students.beneficiaryId.equalsExp(beneficiaries.id)),
    ])
      ..where(beneficiaries.beneficiaryType.equals(_studentType))
      ..orderBy([OrderingTerm(expression: beneficiaries.primaryName)]);
    return query.watch().map(
          (rows) => rows
              .map((row) => (row.readTable(beneficiaries), row.readTable(students)))
              .toList(),
        );
  }

  Stream<List<(Beneficiary, ElderlyBeneficiary)>> watchElderly() {
    final query = select(beneficiaries).join([
      innerJoin(elderly, elderly.beneficiaryId.equalsExp(beneficiaries.id)),
    ])
      ..where(beneficiaries.beneficiaryType.equals(_elderlyType))
      ..orderBy([OrderingTerm(expression: beneficiaries.primaryName)]);
    return query.watch().map(
          (rows) => rows
              .map((row) => (row.readTable(beneficiaries), row.readTable(elderly)))
              .toList(),
        );
  }

  Stream<List<(Beneficiary, MarriedBeneficiary)>> watchMarried() {
    final query = select(beneficiaries).join([
      innerJoin(married, married.beneficiaryId.equalsExp(beneficiaries.id)),
    ])
      ..where(beneficiaries.beneficiaryType.equals(_marriedType))
      ..orderBy([OrderingTerm(expression: beneficiaries.primaryName)]);
    return query.watch().map(
          (rows) => rows
              .map((row) => (row.readTable(beneficiaries), row.readTable(married)))
              .toList(),
        );
  }

  Future<int> insertHousehold(
    BeneficiariesCompanion base,
    HouseholdsCompanion Function(int beneficiaryId) details,
  ) =>
      transaction(() async {
        final id = await into(beneficiaries).insert(base);
        await into(households).insert(details(id));
        return id;
      });

  Future<int> insertStudent(
    BeneficiariesCompanion base,
    StudentsCompanion Function(int beneficiaryId) details,
  ) =>
      transaction(() async {
        final id = await into(beneficiaries).insert(base);
        await into(students).insert(details(id));
        return id;
      });

  Future<int> insertElderly(
    BeneficiariesCompanion base,
    ElderlyCompanion Function(int beneficiaryId) details,
  ) =>
      transaction(() async {
        final id = await into(beneficiaries).insert(base);
        await into(elderly).insert(details(id));
        return id;
      });

  Future<int> insertMarried(
    BeneficiariesCompanion base,
    MarriedCompanion Function(int beneficiaryId) details,
  ) =>
      transaction(() async {
        final id = await into(beneficiaries).insert(base);
        await into(married).insert(details(id));
        return id;
      });

  Future<void> updateHousehold(Beneficiary base, Household details) =>
      transaction(() async {
        await update(beneficiaries).replace(base);
        await update(households).replace(details);
      });

  Future<void> updateStudent(Beneficiary base, Student details) =>
      transaction(() async {
        await update(beneficiaries).replace(base);
        await update(students).replace(details);
      });

  Future<void> updateElderly(Beneficiary base, ElderlyBeneficiary details) =>
      transaction(() async {
        await update(beneficiaries).replace(base);
        await update(elderly).replace(details);
      });

  Future<void> updateMarried(Beneficiary base, MarriedBeneficiary details) =>
      transaction(() async {
        await update(beneficiaries).replace(base);
        await update(married).replace(details);
      });

  Future<int> deleteBeneficiary(int id) =>
      (delete(beneficiaries)..where((t) => t.id.equals(id))).go();
}
