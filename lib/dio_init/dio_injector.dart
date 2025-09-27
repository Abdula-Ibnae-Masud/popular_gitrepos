import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../core/network/network_info.dart';
import '../data/datasources/git_local_datasource.dart';
import '../data/datasources/git_remote_datasource.dart';
import '../data/repositories/git_repository_impl.dart';
import '../data/repositories/git_repository.dart';
import '../presentation/bloc/repos_bloc.dart';

final dioInitialize = GetIt.instance;

Future<void> init() async {
  // External: configure Dio centrally
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.github.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/vnd.github+json'},
    ),
  );

  // Simple logging interceptor for development
  dio.interceptors.add(
    LogInterceptor(
      request: true,
      requestBody: false,
      responseBody: false,
      responseHeader: false,
    ),
  );

  dioInitialize.registerLazySingleton<Dio>(() => dio);

  // Core
  dioInitialize.registerLazySingleton<CheckInternetConnection>(
    () => GetNetworkInfo(),
  );

  // Data sources
  final local = GitLocalDataSource();
  await local.init();
  dioInitialize.registerLazySingleton<GitLocalDataSource>(() => local);
  dioInitialize.registerLazySingleton<GitRemoteDataSource>(
    () => GitRemoteDataSource(client: dioInitialize()),
  );

  // Repository
  dioInitialize.registerLazySingleton<GitRepository>(
    () => GitRepositoryImpl(
      remote: dioInitialize(),
      local: dioInitialize(),
      networkInfo: dioInitialize(),
    ),
  );

  // Bloc
  dioInitialize.registerFactory(() => ReposBloc(dioInitialize()));
}
