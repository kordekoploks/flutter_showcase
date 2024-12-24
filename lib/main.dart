import 'package:eshop/core/usecases/usecase.dart';
import 'package:eshop/objectbox.g.dart';
import 'package:eshop/presentation/blocs/outcome_sub_category/outcome_sub_category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constant/strings.dart';
import 'core/database/ObjectBox.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/data_sources/local/entity/outcome_category_entity.dart';
import 'data/data_sources/local/entity/outcome_sub_category_entity.dart';
import 'domain/usecases/product/get_product_usecase.dart';
import 'presentation/blocs/cart/cart_bloc.dart';
import 'presentation/blocs/category/category_bloc.dart';
import 'presentation/blocs/delivery_info/delivery_info_action/delivery_info_action_cubit.dart';
import 'presentation/blocs/delivery_info/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import 'presentation/blocs/filter/filter_cubit.dart';

import 'core/services/services_locator.dart' as di;
import 'presentation/blocs/home/navbar_cubit.dart';
import 'presentation/blocs/order/order_fetch/order_fetch_cubit.dart';
import 'presentation/blocs/product/product_bloc.dart';
import 'presentation/blocs/user/user_bloc.dart';
import 'presentation/blocs/setting/setting_bloc.dart';

late Store objectBoxStore;
late final Admin _admin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  final sl = GetIt.instance;

  objectBoxStore = await openStore();

  if (Admin.isAvailable()) {
    _admin = Admin(objectBoxStore);
  }
  sl.registerLazySingleton(() => objectBoxStore);
  sl.registerLazySingleton(() => objectBoxStore.box<OutcomeCategoryEntity>());
  sl.registerLazySingleton(
      () => objectBoxStore.box<OutcomeSubCategoryEntity>());
// todo penambahan income category entity
  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavbarCubit(),
        ),
        BlocProvider(
          create: (context) => FilterCubit(),
        ),
        BlocProvider(
          create: (context) => di.sl<ProductBloc>()
            ..add(const GetProducts(FilterProductParams())),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<OutcomeCategoryBloc>()..add(const GetCategories()),
        ),

        //todo tambah income categori bloc provider
        BlocProvider(
          create: (context) => di.sl<OutcomeSubCategoryBloc>(),
        ),

        //todo tambah income sub categori bloc
        BlocProvider(
          create: (context) => di.sl<CartBloc>()..add(const GetCart()),
        ),
        BlocProvider(
          create: (context) => di.sl<UserBloc>()..add(CheckUser()),
        ),
        BlocProvider(
          create: (context) => di.sl<DeliveryInfoActionCubit>(),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<DeliveryInfoFetchCubit>()..fetchDeliveryInfo(),
        ),
        BlocProvider(
          create: (context) => di.sl<OrderFetchCubit>()..getOrders(),
        ),
        BlocProvider(
          create: (context) => di.sl<SettingBloc>()..add(CheckSetting()),
        ),
      ],
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          bool isDarkMode = false;
          if (state is SettingApplied) {
            isDarkMode = state.setting.darkMode;
          }

          return OKToast(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: AppRouter.home,
              onGenerateRoute: AppRouter.onGenerateRoute,
              title: appTitle,
              theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
              builder: EasyLoading.init(),
            ),
          );
        },
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..toastPosition= EasyLoadingToastPosition.bottom
    ..indicatorSize = 60
    ..textColor = Colors.black
    ..radius = 20
    ..backgroundColor = Colors.transparent
    ..maskColor = Colors.white
    ..indicatorColor = Colors.black54
    ..userInteractions = false
    ..dismissOnTap = false
    ..boxShadow = <BoxShadow>[]
    ..indicatorType = EasyLoadingIndicatorType.pouringHourGlass;
}
