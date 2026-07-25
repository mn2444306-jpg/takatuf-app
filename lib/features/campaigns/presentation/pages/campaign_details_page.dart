import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printing/printing.dart';

import '../../../../core/constants/beneficiary_type.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../data/pdf/campaign_pdf_report_generator.dart';
import '../../domain/repositories/campaigns_repository.dart';
import '../cubit/campaign_details_cubit.dart';

class CampaignDetailsPage extends StatelessWidget {
  const CampaignDetailsPage({super.key, required this.campaignId});

  final int campaignId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CampaignDetailsCubit(
        injector<CampaignsRepository>(),
        campaignId: campaignId,
      ),
      child: const _CampaignDetailsView(),
    );
  }
}

class _CampaignDetailsView extends StatefulWidget {
  const _CampaignDetailsView();

  @override
  State<_CampaignDetailsView> createState() => _CampaignDetailsViewState();
}

class _CampaignDetailsViewState extends State<_CampaignDetailsView> {
  bool _isSelectionMode = false;
  final Set<int> _selectedIds = {};

  void _toggleSelectionMode() {
    setState(() {
      _isSelectionMode = !_isSelectionMode;
      _selectedIds.clear();
    });
  }

  void _toggleSelected(int campaignBeneficiaryId) {
    setState(() {
      if (!_selectedIds.remove(campaignBeneficiaryId)) {
        _selectedIds.add(campaignBeneficiaryId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الحملة'),
        actions: [
          IconButton(
            tooltip: _isSelectionMode ? 'إلغاء التحديد' : 'تحديد مستفيدين للتصدير',
            icon: Icon(_isSelectionMode ? Icons.close : Icons.checklist),
            onPressed: _toggleSelectionMode,
          ),
        ],
      ),
      body: BlocBuilder<CampaignDetailsCubit, CampaignDetailsState>(
        builder: (context, state) {
          if (state.isLoading || state.campaign == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              _CampaignHeaderCard(state: state),
              if (_isSelectionMode)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'وضع التحديد: اختر المستفيدين المطلوب تصديرهم لموزّع معيّن',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: state.rows.isEmpty
                    ? const EmptyState(
                        icon: Icons.groups_outlined,
                        message: 'لا يوجد مستفيدون مطابقون ضمن نطاق هذه الحملة.',
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 88),
                        itemCount: state.rows.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final row = state.rows[index];
                          final campaignBeneficiary = row.$1;
                          final beneficiary = row.$2;
                          final received = campaignBeneficiary.status == 'received';
                          final subtitleParts = <String>[
                            if ((beneficiary.phone ?? '').isNotEmpty)
                              beneficiary.phone!,
                            if (campaignBeneficiary.amount != null)
                              'المبلغ: ${campaignBeneficiary.amount!.toStringAsFixed(0)}',
                          ];
                          return CheckboxListTile(
                            value: received,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(beneficiary.primaryName),
                            subtitle: subtitleParts.isEmpty
                                ? null
                                : Text(subtitleParts.join(' • ')),
                            secondary: _isSelectionMode
                                ? Checkbox(
                                    value: _selectedIds.contains(
                                      campaignBeneficiary.id,
                                    ),
                                    onChanged: (_) =>
                                        _toggleSelected(campaignBeneficiary.id),
                                  )
                                : null,
                            onChanged: (_) => context
                                .read<CampaignDetailsCubit>()
                                .toggleReceived(campaignBeneficiary),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton:
          BlocBuilder<CampaignDetailsCubit, CampaignDetailsState>(
            builder: (context, state) {
              if (state.campaign == null) return const SizedBox.shrink();
              if (_isSelectionMode) {
                return FloatingActionButton.extended(
                  onPressed: _selectedIds.isEmpty
                      ? null
                      : () => _exportPdf(
                          context,
                          state,
                          rows: state.rows
                              .where((r) => _selectedIds.contains(r.$1.id))
                              .toList(),
                        ),
                  icon: const Icon(Icons.picture_as_pdf_outlined),
                  label: Text('تصدير المحدَّدين (${_selectedIds.length})'),
                );
              }
              return FloatingActionButton.extended(
                onPressed: () =>
                    _exportPdf(context, state, rows: state.rows),
                icon: const Icon(Icons.picture_as_pdf_outlined),
                label: const Text('تصدير PDF'),
              );
            },
          ),
    );
  }

  Future<void> _exportPdf(
    BuildContext context,
    CampaignDetailsState state, {
    required List<(CampaignBeneficiary, Beneficiary)> rows,
  }) async {
    final bytes = await injector<CampaignPdfReportGenerator>().generate(
      campaign: state.campaign!,
      aidType: state.aidType,
      villages: state.villages,
      residencePlaces: state.residencePlaces,
      rows: rows,
    );
    await Printing.layoutPdf(onLayout: (format) async => bytes);
    if (_isSelectionMode && mounted) {
      setState(() {
        _isSelectionMode = false;
        _selectedIds.clear();
      });
    }
  }
}

class _CampaignHeaderCard extends StatelessWidget {
  const _CampaignHeaderCard({required this.state});

  final CampaignDetailsState state;

  @override
  Widget build(BuildContext context) {
    final campaign = state.campaign!;
    final aidTypeLabel = state.aidType?.name ?? 'مساعدة مالية';
    final type = BeneficiaryType.fromValue(campaign.beneficiaryType);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(campaign.name, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.xs),
              Text('${type.arabicLabel} • $aidTypeLabel'),
              if (state.villages.isNotEmpty)
                Text('القرى: ${state.villages.map((v) => v.name).join('، ')}'),
              if (state.residencePlaces.isNotEmpty)
                Text(
                  'أماكن السكن: ${state.residencePlaces.map((p) => p.name).join('، ')}',
                ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'تم الاستلام ${state.received} من ${state.total}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
