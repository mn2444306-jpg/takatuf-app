import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/repositories/beneficiaries_repository.dart';

typedef ElderlyEntry = (Beneficiary, ElderlyBeneficiary);

class ElderlyState extends Equatable {
  const ElderlyState({this.items = const [], this.isLoading = true});

  final List<ElderlyEntry> items;
  final bool isLoading;

  ElderlyState copyWith({List<ElderlyEntry>? items, bool? isLoading}) =>
      ElderlyState(
        items: items ?? this.items,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [items, isLoading];
}

class ElderlyCubit extends Cubit<ElderlyState> {
  ElderlyCubit(this._repository) : super(const ElderlyState()) {
    _subscription = _repository.watchElderly().listen((items) {
      emit(state.copyWith(items: items, isLoading: false));
    });
  }

  final BeneficiariesRepository _repository;
  late final StreamSubscription<List<ElderlyEntry>> _subscription;

  Future<void> add({
    required String primaryName,
    required int villageId,
    required int residencePlaceId,
    String? phone,
    String? notes,
    required int age,
  }) =>
      _repository.addElderly(
        primaryName: primaryName,
        villageId: villageId,
        residencePlaceId: residencePlaceId,
        phone: phone,
        notes: notes,
        age: age,
      );

  Future<void> update(Beneficiary base, ElderlyBeneficiary details) =>
      _repository.updateElderly(base, details);

  Future<void> remove(int beneficiaryId) => _repository.remove(beneficiaryId);

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
