import 'package:eshop/core/network/LoggingHttpClient.dart';
import 'package:eshop/data/data_sources/local/outcome_sub_category_local_data_source.dart';
import 'package:eshop/data/repositories/outcome_sub_category_repository_impl.dart';
import 'package:eshop/data/repositories/setting_repository_impl.dart';
import 'package:eshop/domain/repositories/account_repository.dart';
import 'package:eshop/domain/repositories/outcome_sub_category_repository.dart';
import 'package:eshop/domain/repositories/setting_repository.dart';
import 'package:eshop/domain/usecases/account/get_cached_account_usecase.dart';
import 'package:eshop/domain/usecases/account/update_account_usecase.dart';
import 'package:eshop/domain/usecases/outcome_category/add_category_usecase.dart';
import 'package:eshop/domain/usecases/delivery_info/clear_local_delivery_info_usecase.dart';
import 'package:eshop/domain/usecases/delivery_info/edit_delivery_info_usecase.dart';
import 'package:eshop/domain/usecases/delivery_info/get_selected_delivery_info_usecase.dart';
import 'package:eshop/domain/usecases/delivery_info/select_delivery_info_usecase.dart';
import 'package:eshop/domain/usecases/order/clear_local_order_usecase.dart';
import 'package:eshop/domain/usecases/outcome_sub_category/add_outcome_sub_category_usecase.dart';
import 'package:eshop/domain/usecases/outcome_sub_category/delete_outcome_sub_category_usecase.dart';
import 'package:eshop/domain/usecases/outcome_sub_category/filter_outcome_sub_category_usecase.dart';
import 'package:eshop/domain/usecases/outcome_sub_category/get_cached_outcome_sub_category_usecase.dart';
import 'package:eshop/domain/usecases/outcome_sub_category/update_outcome_sub_category_usecase.dart';
import 'package:eshop/domain/usecases/setting/get_cached_setting_usecase.dart';
import 'package:eshop/domain/usecases/setting/save_setting_usecase.dart';
import 'package:eshop/domain/usecases/user/edit_full_name_usecase.dart';
import 'package:eshop/domain/usecases/user/edit_usecase.dart';
import 'package:eshop/objectbox.g.dart';
import 'package:eshop/presentation/blocs/account/account_bloc.dart';
import 'package:eshop/presentation/blocs/outcome_sub_category/outcome_sub_category_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_sources/local/account_local_data_source.dart';
import '../../data/data_sources/local/cart_local_data_source.dart';
import '../../data/data_sources/local/income_category_local_data_source.dart';
import '../../data/data_sources/local/income_local_data_source.dart';
import '../../data/data_sources/local/income_sub_category_local_data_source.dart';
import '../../data/data_sources/local/outcome_category_local_data_source.dart';
import '../../data/data_sources/local/delivery_info_local_data_source.dart';
import '../../data/data_sources/local/order_local_data_source.dart';
import '../../data/data_sources/local/product_local_data_source.dart';
import '../../data/data_sources/local/user_local_data_source.dart';
import '../../data/data_sources/remote/cart_remote_data_source.dart';
import '../../data/data_sources/remote/income_category_remote_data_source.dart';
import '../../data/data_sources/remote/outcome_category_remote_data_source.dart';
import '../../data/data_sources/remote/delivery_info_remote_data_source.dart';
import '../../data/data_sources/remote/order_remote_data_source.dart';
import '../../data/data_sources/remote/product_remote_data_source.dart';
import '../../data/data_sources/remote/user_remote_data_source.dart';
import '../../data/repositories/account_repository_impl.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../data/repositories/income_category_repository_impl.dart';
import '../../data/repositories/income_repository_impl.dart';
import '../../data/repositories/income_sub_category_repository_impl.dart';
import '../../data/repositories/outcome_category_repository_impl.dart';
import '../../data/repositories/delivery_info_impl.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/repositories/income_category_repository.dart';
import '../../domain/repositories/income_sub_category_repository.dart';
import '../../domain/repositories/outcome_category_repository.dart';
import '../../domain/repositories/delivery_info_repository.dart';
import '../../domain/repositories/income_repository.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/account/add_account_usecase.dart';
import '../../domain/usecases/account/delete_account_usecase.dart';
import '../../domain/usecases/cart/add_cart_item_usecase.dart';
import '../../domain/usecases/cart/clear_cart_usecase.dart';
import '../../domain/usecases/cart/get_cached_cart_usecase.dart';
import '../../domain/usecases/cart/sync_cart_usecase.dart';
import '../../domain/usecases/income/add_income_sub_category_usecase.dart';
import '../../domain/usecases/income/delete_income_sub_category_usecase.dart';
import '../../domain/usecases/income/filter_income_sub_category_usecase.dart';
import '../../domain/usecases/income/get_cached_income_category_usecase.dart';
import '../../domain/usecases/income/get_cached_income_sub_category_usecase.dart';
import '../../domain/usecases/income/income_category/add_income_category_usecase.dart';
import '../../domain/usecases/income/income_category/delete_income_category_usecase.dart';
import '../../domain/usecases/income/income_category/filter_income_category_usecase.dart';
import '../../domain/usecases/income/income_category/update_income_category_usecase.dart';
import '../../domain/usecases/income/save_income_usecase.dart';
import '../../domain/usecases/income/update_income_sub_category_usecase.dart';
import '../../domain/usecases/outcome_category/delete_category_usecase.dart';
import '../../domain/usecases/outcome_category/filter_category_usecase.dart';
import '../../domain/usecases/outcome_category/get_cached_outcome_category_usecase.dart';
import '../../domain/usecases/outcome_category/get_remote_category_usecase.dart';
import '../../domain/usecases/outcome_category/update_category_usecase.dart';
import '../../domain/usecases/delivery_info/add_dilivey_info_usecase.dart';
import '../../domain/usecases/delivery_info/get_cached_delivery_info_usecase.dart';
import '../../domain/usecases/delivery_info/get_remote_delivery_info_usecase.dart';
import '../../domain/usecases/order/add_order_usecase.dart';
import '../../domain/usecases/order/get_cached_orders_usecase.dart';
import '../../domain/usecases/order/get_remote_orders_usecase.dart';
import '../../domain/usecases/product/get_product_usecase.dart';
import '../../domain/usecases/user/get_cached_user_usecase.dart';
import '../../domain/usecases/user/sign_in_usecase.dart';
import '../../domain/usecases/user/sign_out_usecase.dart';
import '../../domain/usecases/user/sign_up_usecase.dart';
import '../../presentation/blocs/cart/cart_bloc.dart';
import '../../presentation/blocs/category/income_category_bloc.dart';
import '../../presentation/blocs/category/outcome_category_bloc.dart';
import '../../presentation/blocs/delivery_info/delivery_info_action/delivery_info_action_cubit.dart';
import '../../presentation/blocs/delivery_info/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import '../../presentation/blocs/income/income_bloc.dart';
import '../../presentation/blocs/income/income_sub_category_bloc.dart';
import '../../presentation/blocs/order/order_add/order_add_cubit.dart';
import '../../presentation/blocs/order/order_fetch/order_fetch_cubit.dart';
import '../../presentation/blocs/product/product_bloc.dart';
import '../../presentation/blocs/setting/setting_bloc.dart';
import '../../presentation/blocs/user/user_bloc.dart';
import '../database/ObjectBox.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Features - Product
  // Bloc
  sl.registerFactory(
    () => ProductBloc(sl()),
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

  //Features - Category
  // Bloc
  sl.registerFactory(
    () => OutcomeCategoryBloc(sl(), sl(), sl(), sl(), sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetRemoteCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedOutcomeCategoryUseCase(sl()));
  sl.registerLazySingleton(() => AddCategoryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCategoryUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCategoryUseCase(sl()));
  sl.registerLazySingleton(() => FilterCategoryUseCase(sl()));
  // Repository
  sl.registerLazySingleton<OutcomeCategoryRepository>(
    () => OutcomeCategoryRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<OutcomeCategoryRemoteDataSource>(
    () => OutcomeCategoryRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<OutcomeCategoryLocalDataSource>(
    () => OutcomeCategoryLocalDataSourceImpl(
        outcomeCategoryBox: sl(), outcomeSubCategoryBox: sl(), store: sl()),
  );

  //Features - Category
  // Bloc
  sl.registerFactory(
    () => OutcomeSubCategoryBloc(sl(), sl(), sl(), sl(), sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetCachedOutcomeSubCategoryUseCase(sl()));
  sl.registerLazySingleton(() => AddOutcomeSubCategoryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateOutcomeSubCategoryUseCase(sl()));
  sl.registerLazySingleton(() => DeleteOutcomeSubCategoryUseCase(sl()));
  sl.registerLazySingleton(() => FilterOutcomeSubCategoryUseCase(sl()));
  // Repository
  sl.registerLazySingleton<OutcomeSubCategoryRepository>(
    () => OutcomeSubCategoryRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<OutcomeSubCategoryLocalDataSource>(
    () => OutcomeSubCategoryLocalDataSourceImpl(
        outcomeSubCategoryBox: sl(), store: sl()),
  );

  // Bloc
  sl.registerFactory(
        () => IncomeCategoryBloc(sl(), sl(), sl(), sl(), sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetCachedIncomeCategoryUseCase(sl()));
  sl.registerLazySingleton(() => AddIncomeCategoryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateIncomeCategoryUseCase(sl()));
  sl.registerLazySingleton(() => DeleteIncomeCategoryUseCase(sl()));
  sl.registerLazySingleton(() => FilterIncomeCategoryUseCase(sl()));
  // Repository
  sl.registerLazySingleton<IncomeCategoryRepository>(
        () => IncomeCategoryRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<IncomeCategoryRemoteDataSource>(
        () => IncomeCategoryRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<IncomeCategoryLocalDataSource>(
        () => IncomeCategoryLocalDataSourceImpl(
        incomeCategoryBox: sl(), incomeSubCategoryBox: sl(), store: sl()),
  );

  //Features - Category
  // Bloc
  sl.registerFactory(
        () => IncomeSubCategoryBloc(sl(), sl(), sl(), sl(), sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetCachedIncomeSubCategoryUseCase(sl()));
  sl.registerLazySingleton(() => AddIncomeSubCategoryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateIncomeSubCategoryUseCase(sl()));
  sl.registerLazySingleton(() => DeleteIncomeSubCategoryUseCase(sl()));
  sl.registerLazySingleton(() => FilterIncomeSubCategoryUseCase(sl()));
  // Repository
  sl.registerLazySingleton<IncomeSubCategoryRepository>(
        () => IncomeSubCategoryRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<IncomeSubCategoryLocalDataSource>(
        () => IncomeSubCategoryLocalDataSourceImpl(
        incomeSubCategoryBox: sl(), store: sl()),
  );



  //Features - Cart
  // Bloc
  sl.registerFactory(
    () => CartBloc(sl(), sl(), sl(), sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetCachedCartUseCase(sl()));
  sl.registerLazySingleton(() => AddCartUseCase(sl()));
  sl.registerLazySingleton(() => SyncCartUseCase(sl()));
  sl.registerLazySingleton(() => ClearCartUseCase(sl()));
  // Repository
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      userLocalDataSource: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //Features - Delivery Info
  // Bloc
  sl.registerFactory(
    () => DeliveryInfoActionCubit(sl(), sl(), sl()),
  );
  sl.registerFactory(
    () => DeliveryInfoFetchCubit(sl(), sl(), sl(), sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetRemoteDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => AddDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => EditDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => SelectDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => GetSelectedDeliveryInfoInfoUseCase(sl()));
  sl.registerLazySingleton(() => ClearLocalDeliveryInfoUseCase(sl()));
  // Repository
  sl.registerLazySingleton<DeliveryInfoRepository>(
    () => DeliveryInfoRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      userLocalDataSource: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<DeliveryInfoRemoteDataSource>(
    () => DeliveryInfoRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<DeliveryInfoLocalDataSource>(
    () => DeliveryInfoLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //Features - Order
  // Bloc
  sl.registerFactory(
    () => OrderAddCubit(sl()),
  );
  sl.registerFactory(
    () => OrderFetchCubit(sl(), sl(), sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => AddOrderUseCase(sl()));
  sl.registerLazySingleton(() => GetRemoteOrdersUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedOrdersUseCase(sl()));
  sl.registerLazySingleton(() => ClearLocalOrdersUseCase(sl()));
  // Repository
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      userLocalDataSource: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<OrderLocalDataSource>(
    () => OrderLocalDataSourceImpl(sharedPreferences: sl()),
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

  //Setting Feature
  // Bloc
  sl.registerFactory(
    () => SettingBloc(sl(), sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetCachedSettingUseCase(sl()));

  sl.registerLazySingleton(() => SaveSettingUseCase(sl()));

  sl.registerLazySingleton<SettingRepository>(
    () => SettingRepositoryImpl(
      sl(),
    ),
  );

  //Account Feature
  //Setting Feature
  // Bloc
  sl.registerFactory(
    () => AccountBloc(sl(),sl(),sl(),sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetCachedAccountUseCase(sl()));
  sl.registerLazySingleton(() => UpdateAccountUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));
  sl.registerLazySingleton(() => AddAccountUseCase(sl()));

  sl.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AccountLocalDataSource>(
    () => AccountLocalDataSourceImpl(accountBox: sl(), store: sl()),
  );

  //income
  sl.registerFactory(
        () => IncomeBloc(sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => SaveIncomeUseCase(sl()));

  sl.registerLazySingleton<IncomeRepository>(
        () => IncomeRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<IncomeLocalDataSource>(
        () => IncomeLocalDataSourceImpl(incomeBox: sl(), store: sl()),
  );

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
