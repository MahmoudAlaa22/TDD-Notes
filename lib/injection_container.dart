import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'features/add_user/presentation/bloc/cubit/add_user_cubit.dart';
import 'features/add_user/presentation/bloc/cubit/intrests_cubit.dart';
import 'features/setting/data/repositories/setting_repo_impl.dart';
import 'features/setting/presentation/bloc/cubit/setting_cubit.dart';
import 'features/add_user/data/datasources/add_user_remote_datasources.dart';
import 'features/add_user/data/repositories/add_user_repo_impl.dart';
import 'features/add_user/domain/repositories/add_user_repo.dart';
import 'features/add_user/domain/usecases/add_user_usecase.dart';
import 'features/add_user/domain/usecases/get_all_intrests.dart';
import 'features/notes/data/datasources/notes_local_datasources.dart';
import 'features/notes/data/datasources/notes_remote_datasources.dart';
import 'features/notes/data/repositories/notes_repo_impl.dart';
import 'features/notes/domain/usecases/get_all_notes_usecase.dart';
import 'features/notes/domain/usecases/update_note_usecase.dart';
import 'features/notes/presentation/bloc/cubit/edit_note_cubit.dart';
import 'features/notes/presentation/bloc/cubit/notes_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/apis.dart';
import 'core/network/dio_helper.dart';
import 'core/network/network_info.dart';
import 'features/notes/domain/repositories/notes_repo.dart';
import 'features/notes/domain/usecases/get_all_uses.dart';
import 'features/notes/presentation/bloc/cubit/users_cubit.dart';
import 'features/setting/data/datasources/setting_local_datasources.dart';
import 'features/setting/domain/repositories/setting_repo.dart';
import 'features/setting/domain/usecases/setting_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! ############################### External ###############################
  final sharedPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPref);
  final dio = Dio(
    BaseOptions(
      baseUrl: APIs.BASE_URL,
      receiveDataWhenStatusError: true,
    ),
  );
  sl.registerLazySingleton(() => dio);
  final dioHelper = DioHelper(dio: dio);
  sl.registerLazySingleton(() => dioHelper);
  sl.registerLazySingleton(() => InternetConnectionChecker());

  //! ############################### Core ###############################
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  //! ############################### Bloc Or Cubit ###############################
  sl.registerFactory(() => NotesCubit(getAllNotesUsecase: sl()));
  sl.registerFactory(() => UsersCubit(getAllUsersUsecase: sl()));
  sl.registerFactory(() => EditNoteCubit(updateNoteUsecase: sl()));
  sl.registerFactory(() => AddUserCubit(addUserUsecase: sl()));
  sl.registerFactory(() => IntrestsCubit(getAllIntrestsUsecase: sl()));
  sl.registerFactory(() => SettingCubit(settingUsecase: sl()));

  //! ################################# Usecases #################################
  sl.registerLazySingleton(() => GetAllNotesUsecase(notesRepo: sl()));
  sl.registerLazySingleton(() => GetAllUsersUsecase(notesRepo: sl()));
  sl.registerLazySingleton(() => UpdateNoteUsecase(notesRepo: sl()));
  sl.registerLazySingleton(() => AddUserUsecase(addUserRepo: sl()));
  sl.registerLazySingleton(() => GetAllIntrestsUsecase(addUserRepo: sl()));
  sl.registerLazySingleton(() => SettingUsecase(settingRepo: sl()));

  //! ################################# Repository #################################
  sl.registerLazySingleton<NotesRepo>(() => NotesRepoImpl(
        notesRemoteDataSources: sl(),
        networkInfo: sl(),
        notesLocalDatasources: sl(),
        sharedPreferences: sl(),
      ));
  sl.registerLazySingleton<AddUserRepo>(() => AddUserRepoImpl(
        addUserRemoteDataSources: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<SettingRepo>(
      () => SettingRepoImpl(settingLocalDatasources: sl()));

  //! ################################# Datasources #################################
  sl.registerLazySingleton<NotesRemoteDataSources>(
      () => NotesRemoteDataSourcesImpl(dioHelper: sl()));
  sl.registerLazySingleton<NotesLocalDatasources>(
      () => NotesLocalDatasourcesImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<AddUserRemoteDataSources>(
      () => AddUserRemoteDataSourcesImpl(dioHelper: sl()));
  sl.registerLazySingleton<SettingLocalDatasources>(
      () => SettingLocalDatasourcesImpl(sharedPreferences: sl()));
}
