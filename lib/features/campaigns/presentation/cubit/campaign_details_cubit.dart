import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/repositories/campaigns_repository.dart';

class CampaignDetailsState extends Equatable {
  const CampaignDetailsState({
    this.campaign,
    this.aidType,
    this.villages = const [],
    this.residencePlaces = const [],
    this.rows = const [],
    this.isLoading = true,
  });

  final Campaign? campaign;
  final AidType? aidType;
  final List<Village> villages;
  final List<ResidencePlace> residencePlaces;
  final List<(CampaignBeneficiary, Beneficiary)> rows;
  final bool isLoading;

  int get total => rows.length;
  int get received =>
      rows.where((row) => row.$1.status == 'received').length;

  CampaignDetailsState copyWith({
    Campaign? campaign,
    AidType? aidType,
    List<Village>? villages,
    List<ResidencePlace>? residencePlaces,
    List<(CampaignBeneficiary, Beneficiary)>? rows,
    bool? isLoading,
  }) => CampaignDetailsState(
    campaign: campaign ?? this.campaign,
    aidType: aidType ?? this.aidType,
    villages: villages ?? this.villages,
    residencePlaces: residencePlaces ?? this.residencePlaces,
    rows: rows ?? this.rows,
    isLoading: isLoading ?? this.isLoading,
  );

  @override
  List<Object?> get props => [
    campaign,
    aidType,
    villages,
    residencePlaces,
    rows,
    isLoading,
  ];
}

/// يحتاج campaignId وقت التشغيل، لذا يُنشأ مباشرة في BlocProvider.create بصفحة
/// التفاصيل بدل تسجيله في GetIt (لا يوجد registerFactoryParam بالمشروع).
class CampaignDetailsCubit extends Cubit<CampaignDetailsState> {
  CampaignDetailsCubit(this._repository, {required this.campaignId})
    : super(const CampaignDetailsState()) {
    _campaignSubscription = _repository
        .watchCampaignWithAidType(campaignId)
        .listen((data) {
          emit(
            state.copyWith(
              campaign: data.$1,
              aidType: data.$2,
              isLoading: false,
            ),
          );
        });
    _beneficiariesSubscription = _repository
        .watchCampaignBeneficiaries(campaignId)
        .listen((rows) => emit(state.copyWith(rows: rows)));
    _loadScope();
  }

  final CampaignsRepository _repository;
  final int campaignId;
  late final StreamSubscription<(Campaign, AidType)> _campaignSubscription;
  late final StreamSubscription<List<(CampaignBeneficiary, Beneficiary)>>
  _beneficiariesSubscription;

  Future<void> _loadScope() async {
    final villages = await _repository.getCampaignVillages(campaignId);
    final places = await _repository.getCampaignResidencePlaces(campaignId);
    emit(state.copyWith(villages: villages, residencePlaces: places));
  }

  Future<void> toggleReceived(CampaignBeneficiary row) =>
      _repository.setReceived(row.id, row.status != 'received');

  @override
  Future<void> close() {
    _campaignSubscription.cancel();
    _beneficiariesSubscription.cancel();
    return super.close();
  }
}
