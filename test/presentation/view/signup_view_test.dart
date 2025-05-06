import 'package:eshop/l10n/gen_l10n/app_localizations.dart';
import 'package:eshop/presentation/blocs/user/user_bloc.dart';
import 'package:eshop/domain/usecases/user/sign_up_usecase.dart';
import 'package:eshop/presentation/views/authentication/signup_view.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:eshop/presentation/widgets/vw_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserBloc extends Mock implements UserBloc {}

class FakeUserEvent extends Fake implements UserEvent {}

void main() {
  late UserBloc userBloc;

  // Register fallback before all tests
  setUpAll(() {
    registerFallbackValue(FakeUserEvent());
  });

  setUp(() {
    userBloc = MockUserBloc();
    when(() => userBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => userBloc.state).thenReturn(UserInitial());
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      builder: EasyLoading.init(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // Adjust as needed
      ],
      home: BlocProvider<UserBloc>.value(
        value: userBloc,
        child: body,
      ),
    );
  }

  testWidgets('SignUpScreen submits valid form and triggers SignUpUser event',
          (WidgetTester tester) async {
        when(() => userBloc.state).thenReturn(UserInitial());
        when(() => userBloc.stream).thenAnswer((_) => const Stream.empty());
        when(() => userBloc.add(any())).thenReturn(null);

        await tester.pumpWidget(makeTestableWidget(const SignUpScreen()));
        await tester.pumpAndSettle();

        // Fill in all form fields
        await tester.enterText(find.byType(TextFormField).at(0), 'John');
        await tester.enterText(find.byType(TextFormField).at(1), 'Doe');
        await tester.enterText(find.byType(TextFormField).at(2), '08123456789');
        await tester.enterText(find.byType(TextFormField).at(3), 'john@example.com');
        await tester.enterText(find.byType(TextFormField).at(4), 'password123');
        await tester.enterText(find.byType(TextFormField).at(5), 'password123');

        // Tap the checkbox
        final checkboxFinder = find.byType(VwCheckbox);
        await tester.ensureVisible(checkboxFinder);
        await tester.tap(checkboxFinder);
        await tester.pump();

        // Tap the "Sign Up" button
        final signUpButton = find.byType(VwButton);
        await tester.tap(signUpButton);
        await tester.pump();

        verify(() => userBloc.add(any(that: isA<SignUpUser>()))).called(1);
      });

  testWidgets('SignUpScreen shows error when passwords do not match', (WidgetTester tester) async {
    when(() => userBloc.state).thenReturn(UserInitial());
    when(() => userBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => userBloc.add(any())).thenReturn(null);

    await tester.pumpWidget(makeTestableWidget(const SignUpScreen()));
    await tester.pumpAndSettle();


    await tester.enterText(find.byType(TextFormField).at(4), 'password123');
    await tester.enterText(find.byType(TextFormField).at(5), 'password321');

    // Tap the checkbox
    final checkboxFinder = find.byType(VwCheckbox);
    await tester.ensureVisible(checkboxFinder);
    await tester.tap(checkboxFinder);
    await tester.pump();

    // Tap the "Sign Up" button
    final signUpButton = find.byType(VwButton);
    await tester.ensureVisible(signUpButton);
    await tester.tap(signUpButton);
    await tester.pump();

    // Should NOT call userBloc.add due to password mismatch
    verifyNever(() => userBloc.add(any(that: isA<SignUpUser>())));

    // Optional: check error message
    expect(find.textContaining('Password Do Not Match'), findsOneWidget);
  });


  testWidgets('SignUpScreen shows error when phone number is invalid',
          (WidgetTester tester) async {
        when(() => userBloc.state).thenReturn(UserInitial());
        when(() => userBloc.stream).thenAnswer((_) => const Stream.empty());
        when(() => userBloc.add(any())).thenReturn(null);

        await tester.pumpWidget(makeTestableWidget(const SignUpScreen()));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField).at(2), 'abc123'); // Invalid Phone Number

        // Tap the checkbox
        final checkboxFinder = find.byType(VwCheckbox);
        await tester.ensureVisible(checkboxFinder);
        await tester.tap(checkboxFinder);
        await tester.pump();

        // Tap the "Sign Up" button
        final signUpButton = find.byType(VwButton);
        await tester.ensureVisible(signUpButton);
        await tester.tap(signUpButton);
        await tester.pump();

        // Should NOT call userBloc.add due to invalid phone number
        verifyNever(() => userBloc.add(any(that: isA<SignUpUser>())));

        // Optional: check for error message if localized error is predictable
        expect(find.textContaining('Enter A Valid Phone Number'), findsOneWidget);
      });

  testWidgets('SignUpScreen shows error when email is invalid',
          (WidgetTester tester) async {
        when(() => userBloc.state).thenReturn(UserInitial());
        when(() => userBloc.stream).thenAnswer((_) => const Stream.empty());
        when(() => userBloc.add(any())).thenReturn(null);

        await tester.pumpWidget(makeTestableWidget(const SignUpScreen()));
        await tester.pumpAndSettle();

        // Fill in a valid phone number but invalid email
        await tester.enterText(find.byType(TextFormField).at(3), 'not-an-email'); // Invalid Email

        // Tap the checkbox
        final checkboxFinder = find.byType(VwCheckbox);
        await tester.ensureVisible(checkboxFinder);
        await tester.tap(checkboxFinder);
        await tester.pump();

        // Tap the "Sign Up" button
        final signUpButton = find.byType(VwButton);
        await tester.ensureVisible(signUpButton);
        await tester.tap(signUpButton);
        await tester.pump();

        // Should NOT call userBloc.add due to invalid email
        verifyNever(() => userBloc.add(any(that: isA<SignUpUser>())));

        // Optional: check for error message if localized error is predictable
        expect(find.textContaining('Enter A Valid Email'), findsOneWidget);
      });

  testWidgets('SignUpScreen shows error when terms and conditions are not accepted',
          (WidgetTester tester) async {
        when(() => userBloc.state).thenReturn(UserInitial());
        when(() => userBloc.stream).thenAnswer((_) => const Stream.empty());
        when(() => userBloc.add(any())).thenReturn(null);

        await tester.pumpWidget(makeTestableWidget(const SignUpScreen()));
        await tester.pumpAndSettle();

        // Tap the "Sign Up" button
        final signUpButton = find.byType(VwButton);
        await tester.ensureVisible(signUpButton);
        await tester.tap(signUpButton);
        await tester.pump();

        // Should NOT call userBloc.add due to unchecked terms and conditions
        verifyNever(() => userBloc.add(any(that: isA<SignUpUser>())));

        // Optional: check for a visible error message if implemented
        expect(find.textContaining('Terms And Conditions'), findsOneWidget);
      });

}
