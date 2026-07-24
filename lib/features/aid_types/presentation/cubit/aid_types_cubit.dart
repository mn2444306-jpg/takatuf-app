import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/repositories/aid_types_repository.dart';

class AidTypesState extends Equatable {
  const AidTypesState({this.aidTypes = const [], this.isLoading = true});

  final List<AidType> aidTypes;
  final bool isLoading;

  AidTypesState copyWith({List<AidType>? aidTypes, bool? isLoading}) =>
      AidTypesState(
        aidTypes: aidTypes ?? this.aidTypes,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [aidTypes, isLoading];
}

class AidTypesCubit extends Cubit<AidTypesState> {
  AidTypesCubit(this._repository) : super(const AidTypesState()) {
    _subscription = _repository.watchAll().listen((aidTypes) {
      emit(state.copyWith(aidTypes: aidTypes, isLoading: false));
    });
  }

  final AidTypesRepository _repository;
  late final StreamSubscription<List<AidType>> _subscription;

  Future<void> add(String name, {required bool requiresAmount}) =>
      _repository.add(name, requiresAmount: requiresAmount);

  Future<void> update(AidType aidType) => _repository.update(aidType);

  Future<void> remove(int id) => _repository.remove(id);

  Future<bool> isInUse(int id) => _repository.isInUse(id);

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
