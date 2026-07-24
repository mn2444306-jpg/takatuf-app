import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../cubit/students_cubit.dart';
import 'location_dropdowns.dart';

class StudentFormSheet extends StatefulWidget {
  const StudentFormSheet({required this.cubit, this.entry, super.key});

  final StudentsCubit cubit;
  final StudentEntry? entry;

  @override
  State<StudentFormSheet> createState() => _StudentFormSheetState();
}

class _StudentFormSheetState extends State<StudentFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController =
      TextEditingController(text: widget.entry?.$1.primaryName ?? '');
  late final _schoolController =
      TextEditingController(text: widget.entry?.$2.schoolName ?? '');
  late final _stageController =
      TextEditingController(text: widget.entry?.$2.educationStage ?? '');
  late final _gradeController =
      TextEditingController(text: widget.entry?.$2.classGrade ?? '');
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
    _schoolController.dispose();
    _stageController.dispose();
    _gradeController.dispose();
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
                isEditing ? 'تعديل بيانات الطالب' : 'إضافة طالب',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.lg),
              TextFormField(
                controller: _nameController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'اسم الطالب'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'الاسم مطلوب' : null,
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _schoolController,
                decoration: const InputDecoration(labelText: 'المدرسة'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'المدرسة مطلوبة' : null,
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _stageController,
                decoration: const InputDecoration(
                  labelText: 'المرحلة الدراسية',
                  hintText: 'ابتدائي / إعدادي / ثانوي / جامعي',
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'المرحلة مطلوبة' : null,
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _gradeController,
                decoration: const InputDecoration(labelText: 'الصف'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'الصف مطلوب' : null,
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
    final school = _schoolController.text.trim();
    final stage = _stageController.text.trim();
    final grade = _gradeController.text.trim();
    final phone = _phoneController.text.trim();
    final notes = _notesController.text.trim();

    final entry = widget.entry;
    if (entry == null) {
      await widget.cubit.add(
        primaryName: primaryName,
        villageId: _villageId!,
        residencePlaceId: _residencePlaceId!,
        phone: phone.isEmpty ? null : phone,
        notes: notes.isEmpty ? null : notes,
        schoolName: school,
        educationStage: stage,
        classGrade: grade,
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
        schoolName: school,
        educationStage: stage,
        classGrade: grade,
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
