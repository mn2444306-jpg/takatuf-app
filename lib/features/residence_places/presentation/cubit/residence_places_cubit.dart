import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/repositories/residence_places_repository.dart';

class ResidencePlacesState extends Equatable {
  const ResidencePlacesState({this.places = const [], this.isLoading = true});

  final List<ResidencePlace> places;
  final bool isLoading;

  ResidencePlacesState copyWith({
    List<ResidencePlace>? places,
    bool? isLoading,
  }) =>
      ResidencePlacesState(
        places: places ?? this.places,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [places, isLoading];
}

class ResidencePlacesCubit extends Cubit<ResidencePlacesState> {
  ResidencePlacesCubit(this._repository)
      : super(const ResidencePlacesState()) {
    _subscription = _repository.watchAll().listen((places) {
      emit(state.copyWith(places: places, isLoading: false));
    });
  }

  final ResidencePlacesRepository _repository;
  late final StreamSubscription<List<ResidencePlace>> _subscription;

  Future<void> add(String name) => _repository.add(name);

  Future<void> update(ResidencePlace place) => _repository.update(place);

  Future<void> remove(int id) => _repository.remove(id);

  Future<bool> isInUse(int id) => _repository.isInUse(id);

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
