import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/aid_types_table.dart';
import '../tables/campaigns_table.dart';

part 'aid_types_dao.g.dart';

@DriftAccessor(tables: [AidTypes, Campaigns])
class AidTypesDao extends DatabaseAccessor<AppDatabase>
    with _$AidTypesDaoMixin {
  AidTypesDao(super.db);

  Stream<List<AidType>> watchAll() =>
      (select(aidTypes)..orderBy([(t) => OrderingTerm(expression: t.name)]))
          .watch();

  Future<int> insertOne(AidTypesCompanion entry) =>
      into(aidTypes).insert(entry);

  Future<bool> updateOne(AidType entry) => update(aidTypes).replace(entry);

  Future<int> deleteOne(int id) =>
      (delete(aidTypes)..where((t) => t.id.equals(id))).go();

  Future<bool> isInUse(int aidTypeId) async {
    final campaignCount = await (selectOnly(campaigns)
          ..addColumns([campaigns.id.count()])
          ..where(campaigns.aidTypeId.equals(aidTypeId)))
        .map((row) => row.read(campaigns.id.count()) ?? 0)
        .getSingle();
    return campaignCount > 0;
  }
}
