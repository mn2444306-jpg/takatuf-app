import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/beneficiary_type.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/widgets/empty_state.dart';
import '../cubit/campaigns_list_cubit.dart';

class CampaignsListPage extends StatelessWidget {
  const CampaignsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<CampaignsListCubit>(),
      child: const _CampaignsListView(),
    );
  }
}

class _CampaignsListView extends StatelessWidget {
  const _CampaignsListView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الحملات')),
      body: BlocBuilder<CampaignsListCubit, CampaignsListState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.summaries.isEmpty) {
            return EmptyState(
              icon: Icons.campaign_outlined,
              message: 'لا توجد حملات بعد. أنشئ أول حملة مساعدات للبدء.',
              actionLabel: 'إنشاء حملة',
              onAction: () => context.push('/campaigns/new'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: state.summaries.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final summary = state.summaries[index];
              final type = BeneficiaryType.fromValue(
                summary.campaign.beneficiaryType,
              );
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.campaign_outlined),
                ),
                title: Text(summary.campaign.name),
                subtitle: Text(
                  '${type.arabicLabel} • ${summary.aidType.name} • '
                  'تم الاستلام ${summary.received} من ${summary.total}',
                ),
                trailing: const Icon(Icons.chevron_left),
                onTap: () =>
                    context.push('/campaigns/${summary.campaign.id}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/campaigns/new'),
        icon: const Icon(Icons.add),
        label: const Text('حملة جديدة'),
      ),
    );
  }
}
