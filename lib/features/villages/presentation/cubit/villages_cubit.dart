import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/repositories/villages_repository.dart';

class VillagesState extends Equatable {
  const VillagesState({this.villages = const [], this.isLoading = true});

  final List<Village> villages;
  final bool isLoading;

  VillagesState copyWith({List<Village>? villages, bool? isLoading}) =>
      VillagesState(
        villages: villages ?? this.villages,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [villages, isLoading];
}

class VillagesCubit extends Cubit<VillagesState> {
  VillagesCubit(this._repository) : super(const VillagesState()) {
    _subscription = _repository.watchAll().listen((villages) {
      emit(state.copyWith(villages: villages, isLoading: false));
    });
  }

  final VillagesRepository _repository;
  late final StreamSubscription<List<Village>> _subscription;

  Future<void> add(String name, {String? notes}) =>
      _repository.add(name, notes: notes);

  Future<void> update(Village village) => _repository.update(village);

  Future<void> remove(int id) => _repository.remove(id);

  Future<bool> isInUse(int id) => _repository.isInUse(id);

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
