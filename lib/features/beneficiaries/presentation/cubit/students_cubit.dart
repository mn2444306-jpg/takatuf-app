import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/repositories/beneficiaries_repository.dart';

typedef StudentEntry = (Beneficiary, Student);

class StudentsState extends Equatable {
  const StudentsState({this.items = const [], this.isLoading = true});

  final List<StudentEntry> items;
  final bool isLoading;

  StudentsState copyWith({List<StudentEntry>? items, bool? isLoading}) =>
      StudentsState(
        items: items ?? this.items,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [items, isLoading];
}

class StudentsCubit extends Cubit<StudentsState> {
  StudentsCubit(this._repository) : super(const StudentsState()) {
    _subscription = _repository.watchStudents().listen((items) {
      emit(state.copyWith(items: items, isLoading: false));
    });
  }

  final BeneficiariesRepository _repository;
  late final StreamSubscription<List<StudentEntry>> _subscription;

  Future<void> add({
    required String primaryName,
    required int villageId,
    required int residencePlaceId,
    String? phone,
    String? notes,
    required String schoolName,
    required String educationStage,
    required String classGrade,
  }) =>
      _repository.addStudent(
        primaryName: primaryName,
        villageId: villageId,
        residencePlaceId: residencePlaceId,
        phone: phone,
        notes: notes,
        schoolName: schoolName,
        educationStage: educationStage,
        classGrade: classGrade,
      );

  Future<void> update(Beneficiary base, Student details) =>
      _repository.updateStudent(base, details);

  Future<void> remove(int beneficiaryId) => _repository.remove(beneficiaryId);

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
