import 'package:eshop/core/network/LoggingHttpClient.dart';
import 'package:eshop/domain/usecases/user/edit_full_name_usecase.dart';
import 'package:eshop/domain/usecases/user/edit_usecase.dart';
import 'package:eshop/presentation/blocs/product/product_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_sources/local/product_local_data_source.dart';
import '../../data/data_sources/local/user_local_data_source.dart';
import '../../data/data_sources/remote/product_remote_data_source.dart';
import '../../data/data_sources/remote/user_remote_data_source.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/product/get_product_usecase.dart';
import '../../domain/usecases/user/get_cached_user_usecase.dart';
import '../../domain/usecases/user/sign_in_usecase.dart';
import '../../domain/usecases/user/sign_out_usecase.dart';
import '../../domain/usecases/user/sign_up_usecase.dart';
import '../../presentation/blocs/product/product_bloc.dart';
import '../../presentation/blocs/user/user_bloc.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Features - Product
  // Bloc
  sl.registerFactory(
    () => ProductBloc(sl()),
  );
  sl.registerFactory(
        () => ProductController(sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetProductUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );



  //Features - User
  // Bloc
  sl.registerFactory(
    () => UserBloc(sl(), sl(), sl(), sl(), sl(), sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetCachedUserUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => EditUseCase(sl()));
  sl.registerLazySingleton(() => EditFullNameUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sharedPreferences: sl(), secureStorage: sl()),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()),
  );

  //Account Feature
  //Setting Feature
  // Bloc

  ///***********************************************
  ///! Core
  /// sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///! External
  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  // final objectBox = await openStore();
  //
  // if (Admin.isAvailable()) {
  //   Admin _admin = Admin(objectBox);
  // }

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => secureStorage);
  // sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<http.Client>(() => LoggingHttpClient(http.Client()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
