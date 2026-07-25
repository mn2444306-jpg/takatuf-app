import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/repositories/beneficiaries_repository.dart';

typedef MarriedEntry = (Beneficiary, MarriedBeneficiary);

class MarriedState extends Equatable {
  const MarriedState({this.items = const [], this.isLoading = true});

  final List<MarriedEntry> items;
  final bool isLoading;

  MarriedState copyWith({List<MarriedEntry>? items, bool? isLoading}) =>
      MarriedState(
        items: items ?? this.items,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [items, isLoading];
}

class MarriedCubit extends Cubit<MarriedState> {
  MarriedCubit(this._repository) : super(const MarriedState()) {
    _subscription = _repository.watchMarried().listen((items) {
      emit(state.copyWith(items: items, isLoading: false));
    });
  }

  final BeneficiariesRepository _repository;
  late final StreamSubscription<List<MarriedEntry>> _subscription;

  Future<void> add({
    required String primaryName,
    required int villageId,
    required int residencePlaceId,
    String? phone,
    String? notes,
    required double allocatedAmount,
  }) =>
      _repository.addMarried(
        primaryName: primaryName,
        villageId: villageId,
        residencePlaceId: residencePlaceId,
        phone: phone,
        notes: notes,
        allocatedAmount: allocatedAmount,
      );

  Future<void> update(Beneficiary base, MarriedBeneficiary details) =>
      _repository.updateMarried(base, details);

  Future<void> remove(int beneficiaryId) => _repository.remove(beneficiaryId);

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
