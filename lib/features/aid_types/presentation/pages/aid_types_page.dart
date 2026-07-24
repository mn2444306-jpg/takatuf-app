import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/widgets/empty_state.dart';
import '../cubit/aid_types_cubit.dart';

class AidTypesPage extends StatelessWidget {
  const AidTypesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<AidTypesCubit>(),
      child: const _AidTypesView(),
    );
  }
}

class _AidTypesView extends StatelessWidget {
  const _AidTypesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('أنواع المساعدات')),
      body: BlocBuilder<AidTypesCubit, AidTypesState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.aidTypes.isEmpty) {
            return EmptyState(
              icon: Icons.volunteer_activism_outlined,
              message: 'لا توجد أنواع مساعدات بعد. أضف أول نوع للبدء.',
              actionLabel: 'إضافة نوع مساعدة',
              onAction: () => _openForm(context),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: state.aidTypes.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final aidType = state.aidTypes[index];
              return ListTile(
                title: Text(aidType.name),
                subtitle: aidType.requiresAmount
                    ? const Text('يتطلب مبلغاً لكل مستفيد')
                    : null,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      tooltip: 'تعديل',
                      onPressed: () => _openForm(context, aidType: aidType),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      tooltip: 'حذف',
                      onPressed: () => _confirmDelete(context, aidType),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(context),
        icon: const Icon(Icons.add),
        label: const Text('إضافة نوع مساعدة'),
      ),
    );
  }

  Future<void> _openForm(BuildContext context, {AidType? aidType}) {
    final cubit = context.read<AidTypesCubit>();
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _AidTypeFormSheet(cubit: cubit, aidType: aidType),
    );
  }

  Future<void> _confirmDelete(BuildContext context, AidType aidType) async {
    final cubit = context.read<AidTypesCubit>();
    final inUse = await cubit.isInUse(aidType.id);
    if (!context.mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف نوع المساعدة'),
        content: Text(
          inUse
              ? 'هذا النوع مستخدَم حالياً في حملة سابقة. حذفه قد يؤثر على تقاريرها. هل تريد المتابعة؟'
              : 'هل تريد حذف "${aidType.name}"؟',
        ),
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
    if (confirmed ?? false) {
      await cubit.remove(aidType.id);
    }
  }
}

class _AidTypeFormSheet extends StatefulWidget {
  const _AidTypeFormSheet({required this.cubit, this.aidType});

  final AidTypesCubit cubit;
  final AidType? aidType;

  @override
  State<_AidTypeFormSheet> createState() => _AidTypeFormSheetState();
}

class _AidTypeFormSheetState extends State<_AidTypeFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController =
      TextEditingController(text: widget.aidType?.name ?? '');
  late bool _requiresAmount = widget.aidType?.requiresAmount ?? false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.aidType != null;
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isEditing ? 'تعديل نوع المساعدة' : 'إضافة نوع مساعدة',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'اسم نوع المساعدة'),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'الاسم مطلوب'
                  : null,
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('يتطلب مبلغاً لكل مستفيد'),
              subtitle: const Text(
                'فعِّل هذا الخيار إن كان النوع "مبلغ مالي" ليظهر حقل المبلغ عند إنشاء الحملة',
              ),
              value: _requiresAmount,
              onChanged: (value) => setState(() => _requiresAmount = value),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: _submit,
              child: Text(isEditing ? 'حفظ التعديلات' : 'إضافة'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final name = _nameController.text.trim();
    final aidType = widget.aidType;
    if (aidType == null) {
      await widget.cubit.add(name, requiresAmount: _requiresAmount);
    } else {
      await widget.cubit.update(
        aidType.copyWith(name: name, requiresAmount: _requiresAmount),
      );
    }
    if (mounted) Navigator.pop(context);
  }
}
