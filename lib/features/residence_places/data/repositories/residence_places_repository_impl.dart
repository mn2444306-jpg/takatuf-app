import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/residence_places_dao.dart';
import '../../domain/repositories/residence_places_repository.dart';

class ResidencePlacesRepositoryImpl implements ResidencePlacesRepository {
  ResidencePlacesRepositoryImpl(this._dao);

  final ResidencePlacesDao _dao;

  @override
  Stream<List<ResidencePlace>> watchAll() => _dao.watchAll();

  @override
  Future<void> add(String name) => _dao.insertOne(
        ResidencePlacesCompanion.insert(name: name),
      );

  @override
  Future<void> update(ResidencePlace place) => _dao.updateOne(place);

  @override
  Future<void> remove(int id) => _dao.deleteOne(id);

  @override
  Future<bool> isInUse(int id) => _dao.isInUse(id);
}
