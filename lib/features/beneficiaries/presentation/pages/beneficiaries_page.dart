import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../core/di/injector.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/empty_state.dart';
import '../cubit/elderly_cubit.dart';
import '../cubit/households_cubit.dart';
import '../cubit/married_cubit.dart';
import '../cubit/students_cubit.dart';
import '../widgets/elderly_form_sheet.dart';
import '../widgets/household_form_sheet.dart';
import '../widgets/married_form_sheet.dart';
import '../widgets/student_form_sheet.dart';

class BeneficiariesPage extends StatelessWidget {
  const BeneficiariesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المستفيدون'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'بيوت'),
              Tab(text: 'طلاب'),
              Tab(text: 'شيبان'),
              Tab(text: 'متزوجون'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider(
              create: (_) => injector<HouseholdsCubit>(),
              child: const _HouseholdsTab(),
            ),
            BlocProvider(
              create: (_) => injector<StudentsCubit>(),
              child: const _StudentsTab(),
            ),
            BlocProvider(
              create: (_) => injector<ElderlyCubit>(),
              child: const _ElderlyTab(),
            ),
            BlocProvider(
              create: (_) => injector<MarriedCubit>(),
              child: const _MarriedTab(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.hintText});

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.xs,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: hintText,
        ),
      ),
    );
  }
}

class _TabFab extends StatelessWidget {
  const _TabFab({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: AppSpacing.md,
      left: AppSpacing.md,
      child: FloatingActionButton.extended(
        onPressed: onPressed,
        icon: const Icon(Icons.add),
        label: Text(label),
      ),
    );
  }
}

class _HouseholdsTab extends StatefulWidget {
  const _HouseholdsTab();

  @override
  State<_HouseholdsTab> createState() => _HouseholdsTabState();
}

class _HouseholdsTabState extends State<_HouseholdsTab> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() => setState(() {});

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openForm(BuildContext context, {HouseholdEntry? entry}) {
    final cubit = context.read<HouseholdsCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => HouseholdFormSheet(cubit: cubit, entry: entry),
    );
  }

  Future<void> _confirmDelete(BuildContext context, HouseholdEntry entry) async {
    final cubit = context.read<HouseholdsCubit>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف البيت'),
        content: Text('هل تريد حذف "${entry.$1.primaryName}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
    if (confirmed ?? false) await cubit.remove(entry.$1.id);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _SearchField(
              controller: _searchController,
              hintText: 'ابحث بالاسم أو رقم الهاتف',
            ),
            Expanded(
              child: BlocBuilder<HouseholdsCubit, HouseholdsState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final query = _searchController.text.trim();
                  final items = query.isEmpty
                      ? state.items
                      : state.items
                          .where(
                            (e) =>
                                e.$1.primaryName.contains(query) ||
                                (e.$1.phone ?? '').contains(query),
                          )
                          .toList();
                  if (items.isEmpty) {
                    return EmptyState(
                      icon: Icons.holiday_village_outlined,
                      message: state.items.isEmpty
                          ? 'لا توجد بيوت مسجَّلة بعد. أضف أول بيت للبدء.'
                          : 'لا توجد نتائج مطابقة.',
                      actionLabel: state.items.isEmpty ? 'إضافة بيت' : null,
                      onAction: state.items.isEmpty
                          ? () => _openForm(context)
                          : null,
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: 88),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final entry = items[index];
                      final subtitleParts = <String>[
                        'عدد الأفراد: ${entry.$2.familyMembersCount}',
                        if ((entry.$1.phone ?? '').isNotEmpty) entry.$1.phone!,
                      ];
                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.holiday_village_outlined),
                        ),
                        title: Text(entry.$1.primaryName),
                        subtitle: Text(subtitleParts.join(' • ')),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () => _openForm(context, entry: entry),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => _confirmDelete(context, entry),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        _TabFab(label: 'إضافة بيت', onPressed: () => _openForm(context)),
      ],
    );
  }
}

class _StudentsTab extends StatefulWidget {
  const _StudentsTab();

  @override
  State<_StudentsTab> createState() => _StudentsTabState();
}

class _StudentsTabState extends State<_StudentsTab> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() => setState(() {});

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openForm(BuildContext context, {StudentEntry? entry}) {
    final cubit = context.read<StudentsCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => StudentFormSheet(cubit: cubit, entry: entry),
    );
  }

  Future<void> _confirmDelete(BuildContext context, StudentEntry entry) async {
    final cubit = context.read<StudentsCubit>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف الطالب'),
        content: Text('هل تريد حذف "${entry.$1.primaryName}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
    if (confirmed ?? false) await cubit.remove(entry.$1.id);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _SearchField(
              controller: _searchController,
              hintText: 'ابحث بالاسم أو رقم الهاتف',
            ),
            Expanded(
              child: BlocBuilder<StudentsCubit, StudentsState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final query = _searchController.text.trim();
                  final items = query.isEmpty
                      ? state.items
                      : state.items
                          .where(
                            (e) =>
                                e.$1.primaryName.contains(query) ||
                                (e.$1.phone ?? '').contains(query),
                          )
                          .toList();
                  if (items.isEmpty) {
                    return EmptyState(
                      icon: Icons.school_outlined,
                      message: state.items.isEmpty
                          ? 'لا يوجد طلاب مسجَّلون بعد. أضف أول طالب للبدء.'
                          : 'لا توجد نتائج مطابقة.',
                      actionLabel: state.items.isEmpty ? 'إضافة طالب' : null,
                      onAction: state.items.isEmpty
                          ? () => _openForm(context)
                          : null,
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: 88),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final entry = items[index];
                      final subtitleParts = <String>[
                        '${entry.$2.schoolName} • ${entry.$2.classGrade}',
                        if ((entry.$1.phone ?? '').isNotEmpty) entry.$1.phone!,
                      ];
                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.school_outlined),
                        ),
                        title: Text(entry.$1.primaryName),
                        subtitle: Text(subtitleParts.join(' • ')),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () => _openForm(context, entry: entry),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => _confirmDelete(context, entry),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        _TabFab(label: 'إضافة طالب', onPressed: () => _openForm(context)),
      ],
    );
  }
}

class _ElderlyTab extends StatefulWidget {
  const _ElderlyTab();

  @override
  State<_ElderlyTab> createState() => _ElderlyTabState();
}

class _ElderlyTabState extends State<_ElderlyTab> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() => setState(() {});

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openForm(BuildContext context, {ElderlyEntry? entry}) {
    final cubit = context.read<ElderlyCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ElderlyFormSheet(cubit: cubit, entry: entry),
    );
  }

  Future<void> _confirmDelete(BuildContext context, ElderlyEntry entry) async {
    final cubit = context.read<ElderlyCubit>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف الشايب'),
        content: Text('هل تريد حذف "${entry.$1.primaryName}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
    if (confirmed ?? false) await cubit.remove(entry.$1.id);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _SearchField(
              controller: _searchController,
              hintText: 'ابحث بالاسم أو رقم الهاتف',
            ),
            Expanded(
              child: BlocBuilder<ElderlyCubit, ElderlyState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final query = _searchController.text.trim();
                  final items = query.isEmpty
                      ? state.items
                      : state.items
                          .where(
                            (e) =>
                                e.$1.primaryName.contains(query) ||
                                (e.$1.phone ?? '').contains(query),
                          )
                          .toList();
                  if (items.isEmpty) {
                    return EmptyState(
                      icon: Icons.elderly_outlined,
                      message: state.items.isEmpty
                          ? 'لا يوجد شيبان مسجَّلون بعد. أضف أول شايب للبدء.'
                          : 'لا توجد نتائج مطابقة.',
                      actionLabel: state.items.isEmpty ? 'إضافة شايب' : null,
                      onAction: state.items.isEmpty
                          ? () => _openForm(context)
                          : null,
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: 88),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final entry = items[index];
                      final subtitleParts = <String>[
                        'العمر: ${entry.$2.age}',
                        if ((entry.$1.phone ?? '').isNotEmpty) entry.$1.phone!,
                      ];
                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.elderly_outlined),
                        ),
                        title: Text(entry.$1.primaryName),
                        subtitle: Text(subtitleParts.join(' • ')),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () => _openForm(context, entry: entry),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => _confirmDelete(context, entry),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        _TabFab(label: 'إضافة شايب', onPressed: () => _openForm(context)),
      ],
    );
  }
}

class _MarriedTab extends StatefulWidget {
  const _MarriedTab();

  @override
  State<_MarriedTab> createState() => _MarriedTabState();
}

class _MarriedTabState extends State<_MarriedTab> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() => setState(() {});

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openForm(BuildContext context, {MarriedEntry? entry}) {
    final cubit = context.read<MarriedCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => MarriedFormSheet(cubit: cubit, entry: entry),
    );
  }

  Future<void> _confirmDelete(BuildContext context, MarriedEntry entry) async {
    final cubit = context.read<MarriedCubit>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف المتزوج'),
        content: Text('هل تريد حذف "${entry.$1.primaryName}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
    if (confirmed ?? false) await cubit.remove(entry.$1.id);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _SearchField(
              controller: _searchController,
              hintText: 'ابحث بالاسم أو رقم الهاتف',
            ),
            Expanded(
              child: BlocBuilder<MarriedCubit, MarriedState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final query = _searchController.text.trim();
                  final items = query.isEmpty
                      ? state.items
                      : state.items
                          .where(
                            (e) =>
                                e.$1.primaryName.contains(query) ||
                                (e.$1.phone ?? '').contains(query),
                          )
                          .toList();
                  if (items.isEmpty) {
                    return EmptyState(
                      icon: Icons.favorite_outline,
                      message: state.items.isEmpty
                          ? 'لا يوجد متزوجون مسجَّلون بعد. أضف أول متزوج للبدء.'
                          : 'لا توجد نتائج مطابقة.',
                      actionLabel: state.items.isEmpty ? 'إضافة متزوج' : null,
                      onAction: state.items.isEmpty
                          ? () => _openForm(context)
                          : null,
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: 88),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final entry = items[index];
                      final subtitleParts = <String>[
                        DateFormat('yyyy/MM/dd').format(entry.$2.marriageDate),
                        if ((entry.$1.phone ?? '').isNotEmpty) entry.$1.phone!,
                      ];
                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.favorite_outline),
                        ),
                        title: Text(entry.$1.primaryName),
                        subtitle: Text(subtitleParts.join(' • ')),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () => _openForm(context, entry: entry),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => _confirmDelete(context, entry),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        _TabFab(label: 'إضافة متزوج', onPressed: () => _openForm(context)),
      ],
    );
  }
}
