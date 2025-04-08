import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constant/strings.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'domain/usecases/product/get_product_usecase.dart';
import 'l10n/app_localizations.dart';
import 'presentation/blocs/filter/filter_cubit.dart';

import 'core/services/services_locator.dart' as di;
import 'presentation/blocs/home/navbar_cubit.dart';
import 'presentation/blocs/product/product_bloc.dart';
import 'presentation/blocs/user/user_bloc.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  final sl = GetIt.instance;


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
          create: (context) => di.sl<UserBloc>()..add(CheckUser()),
        ),
      ],
      child: OKToast(
        child: MaterialApp(
          locale: Locale('en', 'US'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRouter.home,
          onGenerateRoute: AppRouter.onGenerateRoute,
          title: appTitle,
          theme: AppTheme.lightTheme,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..toastPosition = EasyLoadingToastPosition.bottom
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
