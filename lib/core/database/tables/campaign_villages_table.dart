import 'package:drift/drift.dart';

import 'campaigns_table.dart';
import 'villages_table.dart';

@DataClassName('CampaignVillage')
class CampaignVillages extends Table {
  IntColumn get campaignId => integer().references(Campaigns, #id)();
  IntColumn get villageId => integer().references(Villages, #id)();

  @override
  Set<Column> get primaryKey => {campaignId, villageId};
}
