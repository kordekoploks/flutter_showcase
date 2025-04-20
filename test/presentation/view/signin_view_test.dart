import 'package:eshop/core/router/app_router.dart';
import 'package:eshop/domain/usecases/user/sign_in_usecase.dart';
import 'package:eshop/l10n/gen_l10n/app_localizations.dart';
import 'package:eshop/presentation/blocs/home/navbar_cubit.dart';
import 'package:eshop/presentation/blocs/user/user_bloc.dart';
import 'package:eshop/presentation/views/authentication/signin_view.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserBloc extends Mock implements UserBloc {}
class FakeUserEvent extends Fake implements UserEvent {}
class FakeUserState extends Fake implements UserState {}

class MockNavbarCubit extends Mock implements NavbarCubit {}

void main() {
  late MockUserBloc mockUserBloc;
  late MockNavbarCubit mockNavbarCubit;

  setUpAll(() {
    registerFallbackValue(FakeUserEvent());
    registerFallbackValue(FakeUserState());
  });

  setUp(() {
    mockUserBloc = MockUserBloc();
    mockNavbarCubit = MockNavbarCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>.value(value: mockUserBloc),
          BlocProvider<NavbarCubit>.value(value: mockNavbarCubit),
        ],
        child: const SignInView(),
      ),
    );
  }

  testWidgets('renders SignInView with widgets', (WidgetTester tester) async {
    when(() => mockUserBloc.state).thenReturn(UserInitial());
    when(() => mockUserBloc.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Sign In'), findsNWidgets(2));
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(VwButton), findsOneWidget);
  });


  testWidgets('valid form triggers SignInUser event', (WidgetTester tester) async {
    when(() => mockUserBloc.state).thenReturn(UserInitial());
    when(() => mockUserBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockUserBloc.add(any())).thenReturn(null);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();


    final textFields = find.byType(TextFormField);
    expect(textFields, findsWidgets);

    final emailField = textFields.first;
    final passwordField = textFields.last;

    await tester.enterText(emailField, 'user@example.com');
    await tester.pump();
    await tester.enterText(passwordField, 'password123');
    await tester.pump();

    final signInButton = find.byType(VwButton);
    await tester.tap(signInButton);
    await tester.pump();

    verify(() => mockUserBloc.add(any(that: isA<SignInUser>()))).called(1);
  });

}
