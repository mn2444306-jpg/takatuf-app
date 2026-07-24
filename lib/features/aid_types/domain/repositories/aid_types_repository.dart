import '../../../../core/database/app_database.dart';

abstract class AidTypesRepository {
  Stream<List<AidType>> watchAll();
  Future<void> add(String name, {required bool requiresAmount});
  Future<void> update(AidType aidType);
  Future<void> remove(int id);
  Future<bool> isInUse(int id);
}
