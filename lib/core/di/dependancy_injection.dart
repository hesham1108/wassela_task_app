
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wassela_task_app/core/helpers/local_storage.dart';
import 'package:wassela_task_app/core/helpers/local_storage_helper.dart';
import 'package:wassela_task_app/core/networking/api_service.dart';
import 'package:wassela_task_app/core/networking/dio_factory.dart';
import 'package:wassela_task_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:wassela_task_app/features/auth/data/repo/auth_repo_impl.dart';
import 'package:wassela_task_app/features/auth/presentation/logic/auth_cubit.dart';
import 'package:wassela_task_app/features/splash/presentation/logic/splash_cubit.dart';



final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  //Dio $ ApiService

  Dio dio = await DioFactory.getDio();
  LocalStorage storage = LocalStorage();
  //AppServiceClient instance
  getIt.registerLazySingleton<LocalStorageHelper>(
    () => LocalStorageHelper(localStorage: storage),
  );
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio, storage));
  //splash
  getIt.registerFactory<SplashCubit>(() => SplashCubit(localStorage: storage));

  
  //auth
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(apiService: getIt()),
  );

  getIt.registerLazySingleton<AuthRepoImpl>(
    () => AuthRepoImpl(authRemoteDatasource: getIt()),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(authRepoImpl: getIt(), storage: getIt()),
  );

}
