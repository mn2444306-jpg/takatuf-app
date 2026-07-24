import 'package:get_it/get_it.dart';

import '../../features/aid_types/data/repositories/aid_types_repository_impl.dart';
import '../../features/aid_types/domain/repositories/aid_types_repository.dart';
import '../../features/aid_types/presentation/cubit/aid_types_cubit.dart';
import '../../features/beneficiaries/data/repositories/beneficiaries_repository_impl.dart';
import '../../features/beneficiaries/domain/repositories/beneficiaries_repository.dart';
import '../../features/beneficiaries/presentation/cubit/elderly_cubit.dart';
import '../../features/beneficiaries/presentation/cubit/households_cubit.dart';
import '../../features/beneficiaries/presentation/cubit/married_cubit.dart';
import '../../features/beneficiaries/presentation/cubit/students_cubit.dart';
import '../../features/residence_places/data/repositories/residence_places_repository_impl.dart';
import '../../features/residence_places/domain/repositories/residence_places_repository.dart';
import '../../features/residence_places/presentation/cubit/residence_places_cubit.dart';
import '../../features/villages/data/repositories/villages_repository_impl.dart';
import '../../features/villages/domain/repositories/villages_repository.dart';
import '../../features/villages/presentation/cubit/villages_cubit.dart';
import '../database/app_database.dart';
import '../database/daos/aid_types_dao.dart';
import '../database/daos/beneficiaries_dao.dart';
import '../database/daos/residence_places_dao.dart';
import '../database/daos/villages_dao.dart';

final injector = GetIt.instance;

void setupInjector() {
  injector.registerLazySingleton<AppDatabase>(AppDatabase.new);

  injector.registerLazySingleton<VillagesDao>(
    () => injector<AppDatabase>().villagesDao,
  );
  injector.registerLazySingleton<ResidencePlacesDao>(
    () => injector<AppDatabase>().residencePlacesDao,
  );
  injector.registerLazySingleton<AidTypesDao>(
    () => injector<AppDatabase>().aidTypesDao,
  );
  injector.registerLazySingleton<BeneficiariesDao>(
    () => injector<AppDatabase>().beneficiariesDao,
  );

  injector.registerLazySingleton<VillagesRepository>(
    () => VillagesRepositoryImpl(injector()),
  );
  injector.registerLazySingleton<ResidencePlacesRepository>(
    () => ResidencePlacesRepositoryImpl(injector()),
  );
  injector.registerLazySingleton<AidTypesRepository>(
    () => AidTypesRepositoryImpl(injector()),
  );
  injector.registerLazySingleton<BeneficiariesRepository>(
    () => BeneficiariesRepositoryImpl(injector()),
  );

  injector.registerFactory<VillagesCubit>(() => VillagesCubit(injector()));
  injector.registerFactory<ResidencePlacesCubit>(
    () => ResidencePlacesCubit(injector()),
  );
  injector.registerFactory<AidTypesCubit>(() => AidTypesCubit(injector()));
  injector.registerFactory<HouseholdsCubit>(
    () => HouseholdsCubit(injector()),
  );
  injector.registerFactory<StudentsCubit>(() => StudentsCubit(injector()));
  injector.registerFactory<ElderlyCubit>(() => ElderlyCubit(injector()));
  injector.registerFactory<MarriedCubit>(() => MarriedCubit(injector()));
}
