import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/villages_dao.dart';
import '../../domain/repositories/villages_repository.dart';

class VillagesRepositoryImpl implements VillagesRepository {
  VillagesRepositoryImpl(this._dao);

  final VillagesDao _dao;

  @override
  Stream<List<Village>> watchAll() => _dao.watchAll();

  @override
  Future<void> add(String name, {String? notes}) => _dao.insertOne(
        VillagesCompanion.insert(name: name, notes: Value(notes)),
      );

  @override
  Future<void> update(Village village) => _dao.updateOne(village);

  @override
  Future<void> remove(int id) => _dao.deleteOne(id);

  @override
  Future<bool> isInUse(int id) => _dao.isInUse(id);
}
