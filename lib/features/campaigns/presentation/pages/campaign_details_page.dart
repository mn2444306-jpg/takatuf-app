import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printing/printing.dart';

import '../../../../core/constants/beneficiary_type.dart';
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

class _CampaignDetailsView extends StatelessWidget {
  const _CampaignDetailsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تفاصيل الحملة')),
      body: BlocBuilder<CampaignDetailsCubit, CampaignDetailsState>(
        builder: (context, state) {
          if (state.isLoading || state.campaign == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              _CampaignHeaderCard(state: state),
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
              return FloatingActionButton.extended(
                onPressed: () => _exportPdf(context, state),
                icon: const Icon(Icons.picture_as_pdf_outlined),
                label: const Text('تصدير PDF'),
              );
            },
          ),
    );
  }

  Future<void> _exportPdf(
    BuildContext context,
    CampaignDetailsState state,
  ) async {
    final bytes = await injector<CampaignPdfReportGenerator>().generate(
      campaign: state.campaign!,
      aidType: state.aidType!,
      villages: state.villages,
      residencePlaces: state.residencePlaces,
      rows: state.rows,
    );
    await Printing.layoutPdf(onLayout: (format) async => bytes);
  }
}

class _CampaignHeaderCard extends StatelessWidget {
  const _CampaignHeaderCard({required this.state});

  final CampaignDetailsState state;

  @override
  Widget build(BuildContext context) {
    final campaign = state.campaign!;
    final aidType = state.aidType!;
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
              Text('${type.arabicLabel} • ${aidType.name}'),
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
