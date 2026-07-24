import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/aid_types_dao.dart';
import 'daos/beneficiaries_dao.dart';
import 'daos/residence_places_dao.dart';
import 'daos/villages_dao.dart';
import 'tables/aid_types_table.dart';
import 'tables/beneficiaries_table.dart';
import 'tables/campaign_beneficiaries_table.dart';
import 'tables/campaign_residence_places_table.dart';
import 'tables/campaign_villages_table.dart';
import 'tables/campaigns_table.dart';
import 'tables/elderly_table.dart';
import 'tables/households_table.dart';
import 'tables/married_table.dart';
import 'tables/residence_places_table.dart';
import 'tables/students_table.dart';
import 'tables/villages_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Villages,
    ResidencePlaces,
    AidTypes,
    Beneficiaries,
    Households,
    Students,
    Elderly,
    Married,
    Campaigns,
    CampaignVillages,
    CampaignResidencePlaces,
    CampaignBeneficiaries,
  ],
  daos: [VillagesDao, ResidencePlacesDao, AidTypesDao, BeneficiariesDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (migrator) async {
          await migrator.createAll();
          // فهارس الأداء المذكورة في docs/ARCHITECTURE.md القسم 5.4
          await customStatement(
            'CREATE INDEX idx_beneficiaries_type ON beneficiaries(beneficiary_type);',
          );
          await customStatement(
            'CREATE INDEX idx_beneficiaries_village ON beneficiaries(village_id);',
          );
          await customStatement(
            'CREATE INDEX idx_beneficiaries_residence ON beneficiaries(residence_place_id);',
          );
          await customStatement(
            'CREATE INDEX idx_beneficiaries_phone ON beneficiaries(phone);',
          );
          await customStatement(
            'CREATE INDEX idx_beneficiaries_name ON beneficiaries(primary_name);',
          );
          await customStatement(
            'CREATE INDEX idx_campaign_beneficiaries_campaign ON campaign_beneficiaries(campaign_id);',
          );
          await customStatement(
            'CREATE INDEX idx_campaign_beneficiaries_beneficiary ON campaign_beneficiaries(beneficiary_id);',
          );
          await customStatement(
            'CREATE INDEX idx_campaign_beneficiaries_status ON campaign_beneficiaries(status);',
          );
        },
        beforeOpen: (details) async {
          // ضروري لتفعيل onDelete: cascade بين المستفيدين وجداولهم الفرعية
          await customStatement('PRAGMA foreign_keys = ON;');
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'takatuf.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
