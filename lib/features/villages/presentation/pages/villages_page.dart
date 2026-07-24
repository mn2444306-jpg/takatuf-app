import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/widgets/empty_state.dart';
import '../cubit/villages_cubit.dart';

class VillagesPage extends StatelessWidget {
  const VillagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<VillagesCubit>(),
      child: const _VillagesView(),
    );
  }
}

class _VillagesView extends StatelessWidget {
  const _VillagesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('القرى')),
      body: BlocBuilder<VillagesCubit, VillagesState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.villages.isEmpty) {
            return EmptyState(
              icon: Icons.holiday_village_outlined,
              message: 'لا توجد قرى بعد. أضف أول قرية للبدء.',
              actionLabel: 'إضافة قرية',
              onAction: () => _openForm(context),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: state.villages.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final village = state.villages[index];
              return ListTile(
                title: Text(village.name),
                subtitle: (village.notes == null || village.notes!.isEmpty)
                    ? null
                    : Text(village.notes!),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      tooltip: 'تعديل',
                      onPressed: () => _openForm(context, village: village),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      tooltip: 'حذف',
                      onPressed: () => _confirmDelete(context, village),
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
        label: const Text('إضافة قرية'),
      ),
    );
  }

  Future<void> _openForm(BuildContext context, {Village? village}) {
    final cubit = context.read<VillagesCubit>();
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _VillageFormSheet(cubit: cubit, village: village),
    );
  }

  Future<void> _confirmDelete(BuildContext context, Village village) async {
    final cubit = context.read<VillagesCubit>();
    final inUse = await cubit.isInUse(village.id);
    if (!context.mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف القرية'),
        content: Text(
          inUse
              ? 'هذه القرية مستخدَمة حالياً من قِبل مستفيدين أو حملات. حذفها قد يؤثر على بياناتهم. هل تريد المتابعة؟'
              : 'هل تريد حذف "${village.name}"؟',
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
      await cubit.remove(village.id);
    }
  }
}

class _VillageFormSheet extends StatefulWidget {
  const _VillageFormSheet({required this.cubit, this.village});

  final VillagesCubit cubit;
  final Village? village;

  @override
  State<_VillageFormSheet> createState() => _VillageFormSheetState();
}

class _VillageFormSheetState extends State<_VillageFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController =
      TextEditingController(text: widget.village?.name ?? '');
  late final _notesController =
      TextEditingController(text: widget.village?.notes ?? '');

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.village != null;
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
              isEditing ? 'تعديل القرية' : 'إضافة قرية',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'اسم القرية'),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'الاسم مطلوب'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'ملاحظات (اختياري)'),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
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
    final notes = _notesController.text.trim();
    final village = widget.village;
    if (village == null) {
      await widget.cubit.add(name, notes: notes.isEmpty ? null : notes);
    } else {
      await widget.cubit.update(
        village.copyWith(
          name: name,
          notes: Value(notes.isEmpty ? null : notes),
        ),
      );
    }
    if (mounted) Navigator.pop(context);
  }
}
