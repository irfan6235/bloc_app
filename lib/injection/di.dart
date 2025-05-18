import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../features/auth/data/datasources/auth_remote_datasource.dart'
    show AuthRemoteDataSource, AuthRemoteDataSourceImpl;
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart'
    show AuthRepository;
import '../features/auth/domain/usecases/login_user.dart';
import '../features/auth/presentation/bloc/login_bloc.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => LoginUseCase(authRepository: sl()));
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));
}
