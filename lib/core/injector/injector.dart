import 'package:behalal/data/repository/auth_repository/auth_service.dart';
import 'package:behalal/data/repository/auth_repository/auth_service_impl.dart';
import 'package:behalal/data/repository/dashboard_repository/dashboard_service.dart';
import 'package:behalal/data/repository/dashboard_repository/service_service_impl.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

/// Initializes all dependencies.
/// We register as lazy singletons to boost performance
/// meaning, Get It would instantiate objects on demand
Future<void> init() async {
  //! Repositories
  //eg: sl.registerLazySingleton<IPokemonRemoteDataSource>(() => PokemonRemoteDataSourceImpl(client: sl())
  // );
  sl.registerLazySingleton<AuthenticationService>(() => AuthenticationServiceImpl());
  sl.registerLazySingleton<DashboardServices>(() => DashboardServiceImpl());
  // sl.registerLazySingleton<NewsRepository>(() => GetNewsImpl());
  // sl.registerLazySingleton<ChangePasswordRepository>(() => ChangePasswordImpl());

  //! Data sources
  //eg: sl.registerLazySingleton<ICacheDataSource>(() => CacheDataSourceImpl(sl()));

  //! Core
  //eg: sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  //eg: sl.registerLazySingleton(() => http.Client());
}
