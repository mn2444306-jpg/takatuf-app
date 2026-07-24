import '../../../../core/database/app_database.dart';

abstract class VillagesRepository {
  Stream<List<Village>> watchAll();
  Future<void> add(String name, {String? notes});
  Future<void> update(Village village);
  Future<void> remove(int id);
  Future<bool> isInUse(int id);
}
