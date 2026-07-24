import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/repositories/beneficiaries_repository.dart';

typedef HouseholdEntry = (Beneficiary, Household);

class HouseholdsState extends Equatable {
  const HouseholdsState({this.items = const [], this.isLoading = true});

  final List<HouseholdEntry> items;
  final bool isLoading;

  HouseholdsState copyWith({List<HouseholdEntry>? items, bool? isLoading}) =>
      HouseholdsState(
        items: items ?? this.items,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [items, isLoading];
}

class HouseholdsCubit extends Cubit<HouseholdsState> {
  HouseholdsCubit(this._repository) : super(const HouseholdsState()) {
    _subscription = _repository.watchHouseholds().listen((items) {
      emit(state.copyWith(items: items, isLoading: false));
    });
  }

  final BeneficiariesRepository _repository;
  late final StreamSubscription<List<HouseholdEntry>> _subscription;

  Future<void> add({
    required String primaryName,
    required int villageId,
    required int residencePlaceId,
    String? phone,
    String? notes,
    String? wifeName,
    required int familyMembersCount,
  }) =>
      _repository.addHousehold(
        primaryName: primaryName,
        villageId: villageId,
        residencePlaceId: residencePlaceId,
        phone: phone,
        notes: notes,
        wifeName: wifeName,
        familyMembersCount: familyMembersCount,
      );

  Future<void> update(Beneficiary base, Household details) =>
      _repository.updateHousehold(base, details);

  Future<void> remove(int beneficiaryId) => _repository.remove(beneficiaryId);

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
