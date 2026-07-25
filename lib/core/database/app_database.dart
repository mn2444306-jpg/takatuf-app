import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/aid_types_dao.dart';
import 'daos/beneficiaries_dao.dart';
import 'daos/campaigns_dao.dart';
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
  daos: [
    VillagesDao,
    ResidencePlacesDao,
    AidTypesDao,
    BeneficiariesDao,
    CampaignsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

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
        onUpgrade: (migrator, from, to) async {
          if (from < 3) {
            // الطلاب: حذف المدرسة/المرحلة/الصف (مستفيدو الطلاب جامعيون فقط)
            // وإضافة اسم الجامعة (اختياري) والمبلغ المقرر
            await customStatement('ALTER TABLE students DROP COLUMN school_name;');
            await customStatement(
              'ALTER TABLE students DROP COLUMN education_stage;',
            );
            await customStatement('ALTER TABLE students DROP COLUMN class_grade;');
            await migrator.addColumn(students, students.universityName);
            await migrator.addColumn(students, students.allocatedAmount);

            // الشيبان: حذف العمر، إضافة المبلغ المقرر
            await customStatement('ALTER TABLE elderly DROP COLUMN age;');
            await migrator.addColumn(elderly, elderly.allocatedAmount);

            // المتزوجون: حذف تاريخ الزواج، إضافة المبلغ المقرر
            await customStatement('ALTER TABLE married DROP COLUMN marriage_date;');
            await migrator.addColumn(married, married.allocatedAmount);

            // الحملات: جعل aid_type_id قابلاً لـ NULL (حملات الطلاب/الشيبان/
            // المتزوجين تُعتبر مساعدة مالية تلقائياً بلا نوع مساعدة محدَّد)
            // — عبر إعادة إنشاء الجدول لأن SQLite لا يدعم تعديل NOT NULL مباشرة
            await customStatement('ALTER TABLE campaigns RENAME TO campaigns_old;');
            await migrator.createTable(campaigns);
            await customStatement('''
              INSERT INTO campaigns (id, name, beneficiary_type, aid_type_id, amount_per_beneficiary, notes, created_at)
              SELECT id, name, beneficiary_type, aid_type_id, amount_per_beneficiary, notes, created_at FROM campaigns_old;
            ''');
            await customStatement('DROP TABLE campaigns_old;');
          }
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
