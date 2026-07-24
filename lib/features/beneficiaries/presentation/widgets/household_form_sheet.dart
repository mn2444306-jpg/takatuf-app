import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../cubit/households_cubit.dart';
import 'location_dropdowns.dart';

class HouseholdFormSheet extends StatefulWidget {
  const HouseholdFormSheet({required this.cubit, this.entry, super.key});

  final HouseholdsCubit cubit;
  final HouseholdEntry? entry;

  @override
  State<HouseholdFormSheet> createState() => _HouseholdFormSheetState();
}

class _HouseholdFormSheetState extends State<HouseholdFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController =
      TextEditingController(text: widget.entry?.$1.primaryName ?? '');
  late final _wifeNameController =
      TextEditingController(text: widget.entry?.$2.wifeName ?? '');
  late final _membersController = TextEditingController(
    text: (widget.entry?.$2.familyMembersCount ?? 1).toString(),
  );
  late final _phoneController =
      TextEditingController(text: widget.entry?.$1.phone ?? '');
  late final _notesController =
      TextEditingController(text: widget.entry?.$1.notes ?? '');
  int? _villageId;
  int? _residencePlaceId;
  bool _tappedSubmitWithoutLocation = false;

  @override
  void initState() {
    super.initState();
    _villageId = widget.entry?.$1.villageId;
    _residencePlaceId = widget.entry?.$1.residencePlaceId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _wifeNameController.dispose();
    _membersController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.entry != null;
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.sm,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isEditing ? 'تعديل بيانات البيت' : 'إضافة بيت',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.lg),
              TextFormField(
                controller: _nameController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'اسم رب الأسرة'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'الاسم مطلوب' : null,
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _wifeNameController,
                decoration:
                    const InputDecoration(labelText: 'اسم الزوجة (اختياري)'),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _membersController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'عدد أفراد الأسرة'),
                validator: (v) {
                  final n = int.tryParse(v ?? '');
                  return (n == null || n < 1) ? 'أدخل رقماً صحيحاً' : null;
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              VillageDropdownField(
                selectedId: _villageId,
                onChanged: (id) => setState(() => _villageId = id),
              ),
              if (_tappedSubmitWithoutLocation && _villageId == null)
                _RequiredHint(text: 'اختيار القرية مطلوب'),
              const SizedBox(height: AppSpacing.sm),
              ResidencePlaceDropdownField(
                selectedId: _residencePlaceId,
                onChanged: (id) => setState(() => _residencePlaceId = id),
              ),
              if (_tappedSubmitWithoutLocation && _residencePlaceId == null)
                _RequiredHint(text: 'اختيار مكان السكن مطلوب'),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'رقم الهاتف (اختياري)'),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _notesController,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'ملاحظات (اختياري)'),
              ),
              const SizedBox(height: AppSpacing.lg),
              FilledButton(
                onPressed: _submit,
                child: Text(isEditing ? 'حفظ التعديلات' : 'إضافة'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final formOk = _formKey.currentState!.validate();
    final locationOk = _villageId != null && _residencePlaceId != null;
    if (!formOk || !locationOk) {
      setState(() => _tappedSubmitWithoutLocation = true);
      return;
    }

    final primaryName = _nameController.text.trim();
    final wifeName = _wifeNameController.text.trim();
    final phone = _phoneController.text.trim();
    final notes = _notesController.text.trim();
    final familyMembersCount = int.parse(_membersController.text.trim());

    final entry = widget.entry;
    if (entry == null) {
      await widget.cubit.add(
        primaryName: primaryName,
        villageId: _villageId!,
        residencePlaceId: _residencePlaceId!,
        phone: phone.isEmpty ? null : phone,
        notes: notes.isEmpty ? null : notes,
        wifeName: wifeName.isEmpty ? null : wifeName,
        familyMembersCount: familyMembersCount,
      );
    } else {
      final updatedBase = entry.$1.copyWith(
        primaryName: primaryName,
        villageId: _villageId!,
        residencePlaceId: _residencePlaceId!,
        phone: Value(phone.isEmpty ? null : phone),
        notes: Value(notes.isEmpty ? null : notes),
        updatedAt: DateTime.now(),
      );
      final updatedDetails = entry.$2.copyWith(
        wifeName: Value(wifeName.isEmpty ? null : wifeName),
        familyMembersCount: familyMembersCount,
      );
      await widget.cubit.update(updatedBase, updatedDetails);
    }
    if (mounted) Navigator.pop(context);
  }
}

class _RequiredHint extends StatelessWidget {
  const _RequiredHint({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, right: 4),
      child: Text(
        text,
        style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
      ),
    );
  }
}
