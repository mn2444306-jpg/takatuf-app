import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/beneficiary_type.dart';
import '../../domain/repositories/campaigns_repository.dart';

/// علامة داخلية لتمييز "لم يُمرَّر باراميتر" عن "مُرِّر null صراحةً" في [CampaignWizardState.copyWith].
class _Unset {
  const _Unset();
}

const _unset = _Unset();

class CampaignWizardState extends Equatable {
  const CampaignWizardState({
    this.step = 0,
    this.beneficiaryType,
    this.selectedVillageIds = const {},
    this.selectedResidencePlaceIds = const {},
    this.aidTypeId,
    this.requiresAmount = false,
    this.amountPerBeneficiary,
    this.name = '',
    this.notes,
    this.previewCount,
    this.isLoadingPreview = false,
    this.isSaving = false,
    this.createdCampaignId,
    this.errorMessage,
  });

  static const lastStep = 4;

  final int step;
  final BeneficiaryType? beneficiaryType;
  final Set<int> selectedVillageIds;
  final Set<int> selectedResidencePlaceIds;
  final int? aidTypeId;
  final bool requiresAmount;
  final double? amountPerBeneficiary;
  final String name;
  final String? notes;
  final int? previewCount;
  final bool isLoadingPreview;
  final bool isSaving;
  final int? createdCampaignId;
  final String? errorMessage;

  bool get canContinue => switch (step) {
    0 => beneficiaryType != null,
    1 => selectedVillageIds.isNotEmpty,
    2 => selectedResidencePlaceIds.isNotEmpty,
    3 =>
      aidTypeId != null &&
          (!requiresAmount || (amountPerBeneficiary ?? 0) > 0),
    4 => name.trim().isNotEmpty,
    _ => false,
  };

  CampaignWizardState copyWith({
    int? step,
    Object? beneficiaryType = _unset,
    Set<int>? selectedVillageIds,
    Set<int>? selectedResidencePlaceIds,
    Object? aidTypeId = _unset,
    bool? requiresAmount,
    Object? amountPerBeneficiary = _unset,
    String? name,
    Object? notes = _unset,
    Object? previewCount = _unset,
    bool? isLoadingPreview,
    bool? isSaving,
    Object? createdCampaignId = _unset,
    Object? errorMessage = _unset,
    bool resetPreview = false,
    bool clearError = false,
  }) {
    return CampaignWizardState(
      step: step ?? this.step,
      beneficiaryType: identical(beneficiaryType, _unset)
          ? this.beneficiaryType
          : beneficiaryType as BeneficiaryType?,
      selectedVillageIds: selectedVillageIds ?? this.selectedVillageIds,
      selectedResidencePlaceIds:
          selectedResidencePlaceIds ?? this.selectedResidencePlaceIds,
      aidTypeId: identical(aidTypeId, _unset)
          ? this.aidTypeId
          : aidTypeId as int?,
      requiresAmount: requiresAmount ?? this.requiresAmount,
      amountPerBeneficiary: identical(amountPerBeneficiary, _unset)
          ? this.amountPerBeneficiary
          : amountPerBeneficiary as double?,
      name: name ?? this.name,
      notes: identical(notes, _unset) ? this.notes : notes as String?,
      previewCount: resetPreview
          ? null
          : (identical(previewCount, _unset)
                ? this.previewCount
                : previewCount as int?),
      isLoadingPreview: isLoadingPreview ?? this.isLoadingPreview,
      isSaving: isSaving ?? this.isSaving,
      createdCampaignId: identical(createdCampaignId, _unset)
          ? this.createdCampaignId
          : createdCampaignId as int?,
      errorMessage: clearError
          ? null
          : (identical(errorMessage, _unset)
                ? this.errorMessage
                : errorMessage as String?),
    );
  }

  @override
  List<Object?> get props => [
    step,
    beneficiaryType,
    selectedVillageIds,
    selectedResidencePlaceIds,
    aidTypeId,
    requiresAmount,
    amountPerBeneficiary,
    name,
    notes,
    previewCount,
    isLoadingPreview,
    isSaving,
    createdCampaignId,
    errorMessage,
  ];
}

/// معالج إنشاء حملة من 5 خطوات (§10.4/§13 في docs/ARCHITECTURE.md). Cubit واحد
/// يحمل حالة كل الخطوات مجتمعة بدل cubit منفصل لكل خطوة، لأن المعالج شاشة
/// واحدة (Stepper) وليس عدة شاشات.
class CampaignWizardCubit extends Cubit<CampaignWizardState> {
  CampaignWizardCubit(this._repository) : super(const CampaignWizardState());

  final CampaignsRepository _repository;

  void selectBeneficiaryType(BeneficiaryType type) {
    if (type == state.beneficiaryType) return;
    emit(state.copyWith(beneficiaryType: type, resetPreview: true));
  }

  void toggleVillage(int villageId) {
    final updated = Set<int>.of(state.selectedVillageIds);
    if (!updated.remove(villageId)) updated.add(villageId);
    emit(state.copyWith(selectedVillageIds: updated, resetPreview: true));
  }

  void toggleResidencePlace(int residencePlaceId) {
    final updated = Set<int>.of(state.selectedResidencePlaceIds);
    if (!updated.remove(residencePlaceId)) updated.add(residencePlaceId);
    emit(
      state.copyWith(selectedResidencePlaceIds: updated, resetPreview: true),
    );
  }

  void selectAidType(int aidTypeId, bool requiresAmount) {
    emit(
      state.copyWith(
        aidTypeId: aidTypeId,
        requiresAmount: requiresAmount,
        amountPerBeneficiary: requiresAmount
            ? state.amountPerBeneficiary
            : null,
        resetPreview: true,
      ),
    );
  }

  void setAmount(double? amount) =>
      emit(state.copyWith(amountPerBeneficiary: amount));

  void setName(String name) => emit(state.copyWith(name: name));

  void setNotes(String? notes) => emit(state.copyWith(notes: notes));

  Future<void> nextStep() async {
    if (!state.canContinue || state.step >= CampaignWizardState.lastStep) {
      return;
    }
    final newStep = state.step + 1;
    emit(state.copyWith(step: newStep));
    if (newStep == CampaignWizardState.lastStep) {
      await _refreshPreview();
    }
  }

  void previousStep() {
    if (state.step == 0) return;
    emit(state.copyWith(step: state.step - 1));
  }

  Future<void> _refreshPreview() async {
    final type = state.beneficiaryType;
    if (type == null) return;
    emit(state.copyWith(isLoadingPreview: true));
    final count = await _repository.previewMatchingCount(
      beneficiaryType: type.name,
      villageIds: state.selectedVillageIds.toList(),
      residencePlaceIds: state.selectedResidencePlaceIds.toList(),
    );
    emit(state.copyWith(previewCount: count, isLoadingPreview: false));
  }

  Future<void> submit() async {
    final type = state.beneficiaryType;
    final aidTypeId = state.aidTypeId;
    if (type == null || aidTypeId == null || !state.canContinue) return;

    emit(state.copyWith(isSaving: true, clearError: true));
    try {
      final notes = state.notes?.trim();
      final id = await _repository.createCampaign(
        name: state.name.trim(),
        beneficiaryType: type.name,
        aidTypeId: aidTypeId,
        amountPerBeneficiary: state.requiresAmount
            ? state.amountPerBeneficiary
            : null,
        notes: (notes == null || notes.isEmpty) ? null : notes,
        villageIds: state.selectedVillageIds.toList(),
        residencePlaceIds: state.selectedResidencePlaceIds.toList(),
      );
      emit(state.copyWith(isSaving: false, createdCampaignId: id));
    } catch (_) {
      emit(
        state.copyWith(
          isSaving: false,
          errorMessage: 'حدث خطأ أثناء إنشاء الحملة. حاول مرة أخرى.',
        ),
      );
    }
  }
}
