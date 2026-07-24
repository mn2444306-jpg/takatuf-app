import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/beneficiaries_table.dart';
import '../tables/campaign_villages_table.dart';
import '../tables/villages_table.dart';

part 'villages_dao.g.dart';

@DriftAccessor(tables: [Villages, Beneficiaries, CampaignVillages])
class VillagesDao extends DatabaseAccessor<AppDatabase>
    with _$VillagesDaoMixin {
  VillagesDao(super.db);

  Stream<List<Village>> watchAll() =>
      (select(villages)..orderBy([(t) => OrderingTerm(expression: t.name)]))
          .watch();

  Future<int> insertOne(VillagesCompanion entry) =>
      into(villages).insert(entry);

  Future<bool> updateOne(Village entry) => update(villages).replace(entry);

  Future<int> deleteOne(int id) =>
      (delete(villages)..where((t) => t.id.equals(id))).go();

  Future<bool> isInUse(int villageId) async {
    final beneficiaryCount = await (selectOnly(beneficiaries)
          ..addColumns([beneficiaries.id.count()])
          ..where(beneficiaries.villageId.equals(villageId)))
        .map((row) => row.read(beneficiaries.id.count()) ?? 0)
        .getSingle();
    if (beneficiaryCount > 0) return true;

    final campaignCount = await (selectOnly(campaignVillages)
          ..addColumns([campaignVillages.villageId.count()])
          ..where(campaignVillages.villageId.equals(villageId)))
        .map((row) => row.read(campaignVillages.villageId.count()) ?? 0)
        .getSingle();
    return campaignCount > 0;
  }
}
