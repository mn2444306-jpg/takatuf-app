import '../../../../core/database/app_database.dart';

abstract class BeneficiariesRepository {
  Stream<List<(Beneficiary, Household)>> watchHouseholds();
  Future<void> addHousehold({
    required String primaryName,
    required int villageId,
    required int residencePlaceId,
    String? phone,
    String? notes,
    String? wifeName,
    required int familyMembersCount,
  });
  Future<void> updateHousehold(Beneficiary base, Household details);

  Stream<List<(Beneficiary, Student)>> watchStudents();
  Future<void> addStudent({
    required String primaryName,
    required int villageId,
    required int residencePlaceId,
    String? phone,
    String? notes,
    String? universityName,
    required double allocatedAmount,
  });
  Future<void> updateStudent(Beneficiary base, Student details);

  Stream<List<(Beneficiary, ElderlyBeneficiary)>> watchElderly();
  Future<void> addElderly({
    required String primaryName,
    required int villageId,
    required int residencePlaceId,
    String? phone,
    String? notes,
    required double allocatedAmount,
  });
  Future<void> updateElderly(Beneficiary base, ElderlyBeneficiary details);

  Stream<List<(Beneficiary, MarriedBeneficiary)>> watchMarried();
  Future<void> addMarried({
    required String primaryName,
    required int villageId,
    required int residencePlaceId,
    String? phone,
    String? notes,
    required double allocatedAmount,
  });
  Future<void> updateMarried(Beneficiary base, MarriedBeneficiary details);

  Future<void> remove(int beneficiaryId);
}
