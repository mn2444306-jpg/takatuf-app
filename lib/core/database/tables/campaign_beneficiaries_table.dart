import 'package:drift/drift.dart';

import 'beneficiaries_table.dart';
import 'campaigns_table.dart';

@DataClassName('CampaignBeneficiary')
class CampaignBeneficiaries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get campaignId => integer().references(Campaigns, #id)();
  IntColumn get beneficiaryId => integer().references(Beneficiaries, #id)();
  // 'pending' | 'received'
  TextColumn get status =>
      text().withDefault(const Constant('pending'))();
  RealColumn get amount => real().nullable()();
  DateTimeColumn get receivedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {campaignId, beneficiaryId},
      ];
}
