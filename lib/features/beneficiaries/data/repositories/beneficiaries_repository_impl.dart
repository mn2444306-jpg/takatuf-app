import 'package:drift/drift.dart';

import '../../../../core/constants/beneficiary_type.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/beneficiaries_dao.dart';
import '../../domain/repositories/beneficiaries_repository.dart';

class BeneficiariesRepositoryImpl implements BeneficiariesRepository {
  BeneficiariesRepositoryImpl(this._dao);

  final BeneficiariesDao _dao;

  BeneficiariesCompanion _base({
    required BeneficiaryType type,
    required String primaryName,
    required int villageId,
    required int residencePlaceId,
    String? phone,
    String? notes,
  }) =>
      BeneficiariesCompanion.insert(
        beneficiaryType: type.name,
        primaryName: primaryName,
        villageId: villageId,
        residencePlaceId: residencePlaceId,
        phone: Value(phone),
        notes: Value(notes),
      );

  @override
  Stream<List<(Beneficiary, Household)>> watchHouseholds() =>
      _dao.watchHouseholds();

  @override
  Future<void> addHousehold({
    required String primaryName,
    required int villageId,
    required int residencePlaceId,
    String? phone,
    String? notes,
    String? wifeName,
    required int familyMembersCount,
  }) =>
      _dao.insertHousehold(
        _base(
          type: BeneficiaryType.household,
          primaryName: primaryName,
          villageId: villageId,
          residencePlaceId: residencePlaceId,
          phone: phone,
          notes: notes,
        ),
        (beneficiaryId) => HouseholdsCompanion.insert(
          beneficiaryId: Value(beneficiaryId),
          wifeName: Value(wifeName),
          familyMembersCount: Value(familyMembersCount),
        ),
      );

  @override
  Future<void> updateHousehold(Beneficiary base, Household details) =>
      _dao.updateHousehold(base, details);

  @override
  Stream<List<(Beneficiary, Student)>> watchStudents() => _dao.watchStudents();

  @override
  Future<void> addStudent({
    required String primaryName,
    required int villageId,
    required int residencePlaceId,
    String? phone,
    String? notes,
    String? universityName,
    required double allocatedAmount,
  }) =>
      _dao.insertStudent(
        _base(
          type: BeneficiaryType.student,
          primaryName: primaryName,
          villageId: villageId,
          residencePlaceId: residencePlaceId,
          phone: phone,
          notes: notes,
        ),
        (beneficiaryId) => StudentsCompanion.insert(
          beneficiaryId: Value(beneficiaryId),
          universityName: Value(universityName),
          allocatedAmount: Value(allocatedAmount),
        ),
      );

  @override
  Future<void> updateStudent(Beneficiary base, Student details) =>
      _dao.updateStudent(base, details);

  @override
  Stream<List<(Beneficiary, ElderlyBeneficiary)>> watchElderly() =>
      _dao.watchElderly();

  @override
  Future<void> addElderly({
    required String primaryName,
    required int villageId,
    required int residencePlaceId,
    String? phone,
    String? notes,
    required double allocatedAmount,
  }) =>
      _dao.insertElderly(
        _base(
          type: BeneficiaryType.elderly,
          primaryName: primaryName,
          villageId: villageId,
          residencePlaceId: residencePlaceId,
          phone: phone,
          notes: notes,
        ),
        (beneficiaryId) => ElderlyCompanion.insert(
          beneficiaryId: Value(beneficiaryId),
          allocatedAmount: Value(allocatedAmount),
        ),
      );

  @override
  Future<void> updateElderly(Beneficiary base, ElderlyBeneficiary details) =>
      _dao.updateElderly(base, details);

  @override
  Stream<List<(Beneficiary, MarriedBeneficiary)>> watchMarried() =>
      _dao.watchMarried();

  @override
  Future<void> addMarried({
    required String primaryName,
    required int villageId,
    required int residencePlaceId,
    String? phone,
    String? notes,
    required double allocatedAmount,
  }) =>
      _dao.insertMarried(
        _base(
          type: BeneficiaryType.married,
          primaryName: primaryName,
          villageId: villageId,
          residencePlaceId: residencePlaceId,
          phone: phone,
          notes: notes,
        ),
        (beneficiaryId) => MarriedCompanion.insert(
          beneficiaryId: Value(beneficiaryId),
          allocatedAmount: Value(allocatedAmount),
        ),
      );

  @override
  Future<void> updateMarried(Beneficiary base, MarriedBeneficiary details) =>
      _dao.updateMarried(base, details);

  @override
  Future<void> remove(int beneficiaryId) => _dao.deleteBeneficiary(beneficiaryId);
}
