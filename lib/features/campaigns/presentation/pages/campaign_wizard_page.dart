import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/beneficiary_type.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../aid_types/domain/repositories/aid_types_repository.dart';
import '../../../residence_places/domain/repositories/residence_places_repository.dart';
import '../../../villages/domain/repositories/villages_repository.dart';
import '../cubit/campaign_wizard_cubit.dart';

class CampaignWizardPage extends StatelessWidget {
  const CampaignWizardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<CampaignWizardCubit>(),
      child: const _CampaignWizardView(),
    );
  }
}

class _CampaignWizardView extends StatelessWidget {
  const _CampaignWizardView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حملة جديدة')),
      body: BlocConsumer<CampaignWizardCubit, CampaignWizardState>(
        listener: (context, state) {
          if (state.createdCampaignId != null) {
            context.pushReplacement('/campaigns/${state.createdCampaignId}');
            return;
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<CampaignWizardCubit>();
          final isLast = state.step == CampaignWizardState.lastStep;
          return Stepper(
            currentStep: state.step,
            onStepContinue: state.canContinue
                ? (isLast ? cubit.submit : cubit.nextStep)
                : null,
            onStepCancel: state.step == 0 ? null : cubit.previousStep,
            controlsBuilder: (context, details) => Padding(
              padding: const EdgeInsets.only(top: AppSpacing.md),
              child: Row(
                children: [
                  FilledButton(
                    onPressed: state.isSaving
                        ? null
                        : details.onStepContinue,
                    child: state.isSaving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(isLast ? 'إنشاء الحملة' : 'التالي'),
                  ),
                  if (details.onStepCancel != null) ...[
                    const SizedBox(width: AppSpacing.sm),
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: const Text('رجوع'),
                    ),
                  ],
                ],
              ),
            ),
            steps: [
              Step(
                title: const Text('نوع المستفيدين'),
                isActive: state.step >= 0,
                state: state.step > 0
                    ? StepState.complete
                    : StepState.indexed,
                content: const _BeneficiaryTypeStep(),
              ),
              Step(
                title: const Text('القرى'),
                isActive: state.step >= 1,
                state: state.step > 1
                    ? StepState.complete
                    : StepState.indexed,
                content: const _VillagesStep(),
              ),
              Step(
                title: const Text('أماكن السكن'),
                isActive: state.step >= 2,
                state: state.step > 2
                    ? StepState.complete
                    : StepState.indexed,
                content: const _ResidencePlacesStep(),
              ),
              Step(
                title: const Text('نوع المساعدة'),
                isActive: state.step >= 3,
                state: state.step > 3
                    ? StepState.complete
                    : StepState.indexed,
                content: const _AidTypeStep(),
              ),
              Step(
                title: const Text('المراجعة والإنشاء'),
                isActive: state.step >= 4,
                state: StepState.indexed,
                content: const _ReviewStep(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BeneficiaryTypeStep extends StatelessWidget {
  const _BeneficiaryTypeStep();

  static const _icons = {
    BeneficiaryType.household: Icons.holiday_village_outlined,
    BeneficiaryType.student: Icons.school_outlined,
    BeneficiaryType.elderly: Icons.elderly_outlined,
    BeneficiaryType.married: Icons.favorite_outline,
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignWizardCubit, CampaignWizardState>(
      buildWhen: (previous, current) =>
          previous.beneficiaryType != current.beneficiaryType,
      builder: (context, state) {
        return Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final type in BeneficiaryType.values)
              _TypeCard(
                type: type,
                icon: _icons[type]!,
                selected: state.beneficiaryType == type,
                onTap: () => context
                    .read<CampaignWizardCubit>()
                    .selectBeneficiaryType(type),
              ),
          ],
        );
      },
    );
  }
}

class _TypeCard extends StatelessWidget {
  const _TypeCard({
    required this.type,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final BeneficiaryType type;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 150,
      child: Card(
        color: selected ? colorScheme.primaryContainer : null,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 32,
                  color: selected ? colorScheme.primary : null,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(type.arabicLabel),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VillagesStep extends StatefulWidget {
  const _VillagesStep();

  @override
  State<_VillagesStep> createState() => _VillagesStepState();
}

class _VillagesStepState extends State<_VillagesStep> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Village>>(
      stream: injector<VillagesRepository>().watchAll(),
      builder: (context, snapshot) {
        final villages = snapshot.data ?? const [];
        final query = _searchController.text.trim();
        final filtered = query.isEmpty
            ? villages
            : villages.where((v) => v.name.contains(query)).toList();
        return BlocBuilder<CampaignWizardCubit, CampaignWizardState>(
          buildWhen: (previous, current) =>
              previous.selectedVillageIds != current.selectedVillageIds,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'ابحث عن قرية',
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                if (filtered.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                    child: Text('لا توجد قرى مطابقة'),
                  )
                else
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 280),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (final village in filtered)
                          CheckboxListTile(
                            title: Text(village.name),
                            value: state.selectedVillageIds.contains(
                              village.id,
                            ),
                            onChanged: (_) => context
                                .read<CampaignWizardCubit>()
                                .toggleVillage(village.id),
                          ),
                      ],
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

class _ResidencePlacesStep extends StatefulWidget {
  const _ResidencePlacesStep();

  @override
  State<_ResidencePlacesStep> createState() => _ResidencePlacesStepState();
}

class _ResidencePlacesStepState extends State<_ResidencePlacesStep> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ResidencePlace>>(
      stream: injector<ResidencePlacesRepository>().watchAll(),
      builder: (context, snapshot) {
        final places = snapshot.data ?? const [];
        final query = _searchController.text.trim();
        final filtered = query.isEmpty
            ? places
            : places.where((p) => p.name.contains(query)).toList();
        return BlocBuilder<CampaignWizardCubit, CampaignWizardState>(
          buildWhen: (previous, current) =>
              previous.selectedResidencePlaceIds !=
              current.selectedResidencePlaceIds,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'ابحث عن مكان سكن',
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                if (filtered.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                    child: Text('لا توجد أماكن سكن مطابقة'),
                  )
                else
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 280),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (final place in filtered)
                          CheckboxListTile(
                            title: Text(place.name),
                            value: state.selectedResidencePlaceIds.contains(
                              place.id,
                            ),
                            onChanged: (_) => context
                                .read<CampaignWizardCubit>()
                                .toggleResidencePlace(place.id),
                          ),
                      ],
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

class _AidTypeStep extends StatelessWidget {
  const _AidTypeStep();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AidType>>(
      stream: injector<AidTypesRepository>().watchAll(),
      builder: (context, snapshot) {
        final aidTypes = snapshot.data ?? const [];
        return BlocBuilder<CampaignWizardCubit, CampaignWizardState>(
          builder: (context, state) {
            final cubit = context.read<CampaignWizardCubit>();
            final requiresAmountByAidTypeId = {
              for (final aidType in aidTypes) aidType.id: aidType.requiresAmount,
            };
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RadioGroup<int>(
                  groupValue: state.aidTypeId,
                  onChanged: (id) => cubit.selectAidType(
                    id!,
                    requiresAmountByAidTypeId[id] ?? false,
                  ),
                  child: Column(
                    children: [
                      for (final aidType in aidTypes)
                        RadioListTile<int>(
                          value: aidType.id,
                          title: Text(aidType.name),
                          subtitle: aidType.requiresAmount
                              ? const Text('يتطلب مبلغاً لكل مستفيد')
                              : null,
                        ),
                    ],
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child: state.requiresAmount
                      ? Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.sm),
                          child: TextFormField(
                            key: const ValueKey('campaign-amount-field'),
                            initialValue:
                                state.amountPerBeneficiary?.toStringAsFixed(
                                  0,
                                ) ??
                                '',
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'المبلغ لكل مستفيد',
                            ),
                            onChanged: (value) =>
                                cubit.setAmount(double.tryParse(value)),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _ReviewStep extends StatelessWidget {
  const _ReviewStep();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignWizardCubit, CampaignWizardState>(
      builder: (context, state) {
        final cubit = context.read<CampaignWizardCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              initialValue: state.name,
              decoration: const InputDecoration(labelText: 'اسم الحملة'),
              onChanged: cubit.setName,
            ),
            const SizedBox(height: AppSpacing.sm),
            TextFormField(
              initialValue: state.notes ?? '',
              decoration: const InputDecoration(
                labelText: 'ملاحظات (اختياري)',
              ),
              maxLines: 2,
              onChanged: cubit.setNotes,
            ),
            const SizedBox(height: AppSpacing.md),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: state.isLoadingPreview
                    ? const Center(child: CircularProgressIndicator())
                    : Text(
                        'سيتم توزيع هذه الحملة على ${state.previewCount ?? 0} '
                        'مستفيد مطابق للشروط المختارة.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
