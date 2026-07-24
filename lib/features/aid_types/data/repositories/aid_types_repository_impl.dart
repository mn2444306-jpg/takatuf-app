import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/aid_types_dao.dart';
import '../../domain/repositories/aid_types_repository.dart';

class AidTypesRepositoryImpl implements AidTypesRepository {
  AidTypesRepositoryImpl(this._dao);

  final AidTypesDao _dao;

  @override
  Stream<List<AidType>> watchAll() => _dao.watchAll();

  @override
  Future<void> add(String name, {required bool requiresAmount}) =>
      _dao.insertOne(
        AidTypesCompanion.insert(
          name: name,
          requiresAmount: Value(requiresAmount),
        ),
      );

  @override
  Future<void> update(AidType aidType) => _dao.updateOne(aidType);

  @override
  Future<void> remove(int id) => _dao.deleteOne(id);

  @override
  Future<bool> isInUse(int id) => _dao.isInUse(id);
}
