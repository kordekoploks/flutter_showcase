import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:oktoast/oktoast.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'core/services/services_locator.dart' as di;
import 'core/constant/strings.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'domain/usecases/product/get_product_usecase.dart';
import 'presentation/blocs/home/navbar_cubit.dart';
import 'presentation/blocs/filter/filter_cubit.dart';
import 'presentation/blocs/product/product_bloc.dart';
import 'presentation/blocs/user/user_bloc.dart';
import 'l10n/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Uncomment to use Firebase Auth emulator locally
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  await di.init();
  _configLoading();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final sl = GetIt.instance;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavbarCubit()),
        BlocProvider(create: (_) => FilterCubit()),
        BlocProvider(create: (_) => sl<ProductBloc>()..add(const GetProducts(FilterProductParams()))),
        BlocProvider(create: (_) => sl<UserBloc>()..add(CheckUser())),
      ],
      child: OKToast(
        child: MaterialApp(
          title: appTitle,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          initialRoute: AppRouter.home,
          onGenerateRoute: AppRouter.onGenerateRoute,
          builder: EasyLoading.init(),
          locale: const Locale('en', 'US'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}

void _configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 60
    ..radius = 20
    ..textColor = Colors.black
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.black54
    ..maskColor = Colors.white
    ..userInteractions = false
    ..dismissOnTap = false
    ..boxShadow = []
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..indicatorType = EasyLoadingIndicatorType.pouringHourGlass;
}
