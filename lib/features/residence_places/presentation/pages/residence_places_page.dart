import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/widgets/empty_state.dart';
import '../cubit/residence_places_cubit.dart';

class ResidencePlacesPage extends StatelessWidget {
  const ResidencePlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<ResidencePlacesCubit>(),
      child: const _ResidencePlacesView(),
    );
  }
}

class _ResidencePlacesView extends StatelessWidget {
  const _ResidencePlacesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('أماكن السكن')),
      body: BlocBuilder<ResidencePlacesCubit, ResidencePlacesState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.places.isEmpty) {
            return EmptyState(
              icon: Icons.location_city_outlined,
              message: 'لا توجد أماكن سكن بعد. أضف أول مكان للبدء.',
              actionLabel: 'إضافة مكان سكن',
              onAction: () => _openForm(context),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: state.places.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final place = state.places[index];
              return ListTile(
                title: Text(place.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      tooltip: 'تعديل',
                      onPressed: () => _openForm(context, place: place),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      tooltip: 'حذف',
                      onPressed: () => _confirmDelete(context, place),
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
        label: const Text('إضافة مكان سكن'),
      ),
    );
  }

  Future<void> _openForm(BuildContext context, {ResidencePlace? place}) {
    final cubit = context.read<ResidencePlacesCubit>();
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ResidencePlaceFormSheet(cubit: cubit, place: place),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    ResidencePlace place,
  ) async {
    final cubit = context.read<ResidencePlacesCubit>();
    final inUse = await cubit.isInUse(place.id);
    if (!context.mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف مكان السكن'),
        content: Text(
          inUse
              ? 'هذا المكان مستخدَم حالياً من قِبل مستفيدين أو حملات. حذفه قد يؤثر على بياناتهم. هل تريد المتابعة؟'
              : 'هل تريد حذف "${place.name}"؟',
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
      await cubit.remove(place.id);
    }
  }
}

class _ResidencePlaceFormSheet extends StatefulWidget {
  const _ResidencePlaceFormSheet({required this.cubit, this.place});

  final ResidencePlacesCubit cubit;
  final ResidencePlace? place;

  @override
  State<_ResidencePlaceFormSheet> createState() =>
      _ResidencePlaceFormSheetState();
}

class _ResidencePlaceFormSheetState extends State<_ResidencePlaceFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController =
      TextEditingController(text: widget.place?.name ?? '');

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.place != null;
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
              isEditing ? 'تعديل مكان السكن' : 'إضافة مكان سكن',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'اسم مكان السكن'),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'الاسم مطلوب'
                  : null,
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
    final place = widget.place;
    if (place == null) {
      await widget.cubit.add(name);
    } else {
      await widget.cubit.update(place.copyWith(name: name));
    }
    if (mounted) Navigator.pop(context);
  }
}
