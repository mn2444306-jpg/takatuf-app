import 'package:drift/drift.dart';

import 'campaigns_table.dart';
import 'residence_places_table.dart';

@DataClassName('CampaignResidencePlace')
class CampaignResidencePlaces extends Table {
  IntColumn get campaignId => integer().references(Campaigns, #id)();
  IntColumn get residencePlaceId =>
      integer().references(ResidencePlaces, #id)();

  @override
  Set<Column> get primaryKey => {campaignId, residencePlaceId};
}
