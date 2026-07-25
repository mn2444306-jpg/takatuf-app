import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/constants/beneficiary_type.dart';
import '../../../../core/database/app_database.dart';

/// يبني تقرير PDF لحملة واحدة (§19.1 من docs/ARCHITECTURE.md): ترويسة ببيانات
/// الحملة، جدول بالمستفيدين وحالة الاستلام (وعمود المبلغ إن كان نوع المساعدة
/// يتطلب مبلغاً)، وتذييل بإجمالي الأعداد. يُحمَّل خط Cairo مرة واحدة ويُخزَّن
/// لتفادي إعادة قراءته من الأصول عند كل تصدير.
class CampaignPdfReportGenerator {
  pw.Font? _regularFont;
  pw.Font? _boldFont;

  Future<void> _ensureFontsLoaded() async {
    if (_regularFont != null && _boldFont != null) return;
    final regularData = await rootBundle.load('assets/fonts/Cairo-Regular.ttf');
    final boldData = await rootBundle.load('assets/fonts/Cairo-Bold.ttf');
    _regularFont = pw.Font.ttf(regularData);
    _boldFont = pw.Font.ttf(boldData);
  }

  Future<Uint8List> generate({
    required Campaign campaign,
    required AidType? aidType,
    required List<Village> villages,
    required List<ResidencePlace> residencePlaces,
    required List<(CampaignBeneficiary, Beneficiary)> rows,
  }) async {
    await _ensureFontsLoaded();

    final villageNames = {for (final v in villages) v.id: v.name};
    final placeNames = {for (final p in residencePlaces) p.id: p.name};
    // بلا نوع مساعدة محدَّد = حملة مساعدة مالية تلقائياً (طلاب/شيبان/متزوجون)،
    // فتُعرض المبالغ دائماً.
    final showAmount = aidType?.requiresAmount ?? true;
    final receivedCount = rows
        .where((row) => row.$1.status == 'received')
        .length;
    final totalAmount = rows.fold<double>(
      0,
      (sum, row) => sum + (row.$1.amount ?? 0),
    );

    final doc = pw.Document(
      theme: pw.ThemeData.withFont(base: _regularFont!, bold: _boldFont!),
    );

    doc.addPage(
      pw.MultiPage(
        textDirection: pw.TextDirection.rtl,
        pageFormat: PdfPageFormat.a4,
        footer: (context) => pw.Container(
          alignment: pw.Alignment.center,
          margin: const pw.EdgeInsets.only(top: 8),
          child: pw.Text(
            'صفحة ${context.pageNumber} من ${context.pagesCount}',
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
          ),
        ),
        build: (context) => [
          _buildHeader(campaign, aidType, villages, residencePlaces),
          pw.SizedBox(height: 16),
          _buildTable(rows, villageNames, placeNames, showAmount),
          pw.SizedBox(height: 12),
          _buildSummary(
            total: rows.length,
            received: receivedCount,
            totalAmount: showAmount ? totalAmount : null,
          ),
        ],
      ),
    );

    return doc.save();
  }

  pw.Widget _buildHeader(
    Campaign campaign,
    AidType? aidType,
    List<Village> villages,
    List<ResidencePlace> residencePlaces,
  ) {
    final createdAt = DateFormat('yyyy/MM/dd HH:mm').format(campaign.createdAt);
    final beneficiaryType = BeneficiaryType.fromValue(
      campaign.beneficiaryType,
    );
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          campaign.name,
          style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'تاريخ الإنشاء: $createdAt',
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
        ),
        pw.Divider(height: 16),
        _infoRow('نوع المستفيدين', beneficiaryType.arabicLabel),
        _infoRow('نوع المساعدة', aidType?.name ?? 'مساعدة مالية'),
        if (campaign.amountPerBeneficiary != null)
          _infoRow(
            'المبلغ لكل مستفيد',
            campaign.amountPerBeneficiary!.toStringAsFixed(0),
          ),
        _infoRow('القرى المشمولة', villages.map((v) => v.name).join('، ')),
        _infoRow(
          'أماكن السكن المشمولة',
          residencePlaces.map((p) => p.name).join('، '),
        ),
        if (campaign.notes != null && campaign.notes!.trim().isNotEmpty)
          _infoRow('ملاحظات', campaign.notes!),
      ],
    );
  }

  pw.Widget _infoRow(String label, String value) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 3),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          '$label: ',
          style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
        ),
        pw.Expanded(
          child: pw.Text(
            value.isEmpty ? '—' : value,
            style: const pw.TextStyle(fontSize: 11),
          ),
        ),
      ],
    ),
  );

  pw.Widget _buildTable(
    List<(CampaignBeneficiary, Beneficiary)> rows,
    Map<int, String> villageNames,
    Map<int, String> placeNames,
    bool showAmount,
  ) {
    final headers = [
      'م',
      'الاسم',
      'القرية',
      'مكان السكن',
      'الهاتف',
      if (showAmount) 'المبلغ',
      'حالة الاستلام',
    ];

    final data = <List<String>>[
      for (var i = 0; i < rows.length; i++)
        [
          '${i + 1}',
          rows[i].$2.primaryName,
          villageNames[rows[i].$2.villageId] ?? '—',
          placeNames[rows[i].$2.residencePlaceId] ?? '—',
          rows[i].$2.phone ?? '—',
          if (showAmount) (rows[i].$1.amount?.toStringAsFixed(0) ?? '—'),
          rows[i].$1.status == 'received' ? '☑ تم الاستلام' : '☐ لم يستلم',
        ],
    ];

    return pw.TableHelper.fromTextArray(
      headers: headers,
      data: data,
      tableDirection: pw.TextDirection.rtl,
      headerDirection: pw.TextDirection.rtl,
      cellAlignment: pw.Alignment.centerRight,
      headerAlignment: pw.Alignment.center,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
      cellStyle: const pw.TextStyle(fontSize: 9),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.blueGrey100),
      cellPadding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      border: pw.TableBorder.all(color: PdfColors.grey400, width: .5),
    );
  }

  pw.Widget _buildSummary({
    required int total,
    required int received,
    double? totalAmount,
  }) {
    final notReceived = total - received;
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('إجمالي المستفيدين: $total'),
          pw.Text('تم الاستلام: $received'),
          pw.Text('لم يستلم: $notReceived'),
          if (totalAmount != null)
            pw.Text('إجمالي المبالغ: ${totalAmount.toStringAsFixed(0)}'),
        ],
      ),
    );
  }
}
