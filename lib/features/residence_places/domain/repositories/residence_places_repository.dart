import '../../../../core/database/app_database.dart';

abstract class ResidencePlacesRepository {
  Stream<List<ResidencePlace>> watchAll();
  Future<void> add(String name);
  Future<void> update(ResidencePlace place);
  Future<void> remove(int id);
  Future<bool> isInUse(int id);
}
