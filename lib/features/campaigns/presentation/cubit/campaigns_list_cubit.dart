import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/daos/campaigns_dao.dart';
import '../../domain/repositories/campaigns_repository.dart';

class CampaignsListState extends Equatable {
  const CampaignsListState({this.summaries = const [], this.isLoading = true});

  final List<CampaignSummary> summaries;
  final bool isLoading;

  CampaignsListState copyWith({
    List<CampaignSummary>? summaries,
    bool? isLoading,
  }) => CampaignsListState(
    summaries: summaries ?? this.summaries,
    isLoading: isLoading ?? this.isLoading,
  );

  @override
  List<Object?> get props => [summaries, isLoading];
}

class CampaignsListCubit extends Cubit<CampaignsListState> {
  CampaignsListCubit(this._repository) : super(const CampaignsListState()) {
    _subscription = _repository.watchAllSummaries().listen((summaries) {
      emit(state.copyWith(summaries: summaries, isLoading: false));
    });
  }

  final CampaignsRepository _repository;
  late final StreamSubscription<List<CampaignSummary>> _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
