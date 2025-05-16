import 'package:eshop/presentation/blocs/home/navbar_cubit.dart';
import 'package:eshop/presentation/blocs/user/user_bloc.dart';
import 'package:eshop/presentation/views/authentication/signin_view.dart';
import 'package:eshop/presentation/views/main/home/home_view.dart';
import 'package:eshop/presentation/views/main/main_view.dart';
import 'package:eshop/presentation/views/main/other/profile/profile_pengguna.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNavbarCubit extends Mock implements NavbarCubit {}

class MockUserBloc extends Mock implements UserBloc {}

void main() {
  late MockNavbarCubit mockNavbarCubit;
  late MockUserBloc mockUserBloc;

  setUp(() {
    mockNavbarCubit = MockNavbarCubit();
    mockUserBloc = MockUserBloc();
  });

  testWidgets('MainView displays the correct page based on NavbarCubit and UserBloc', (tester) async {
    // Arrange
    when(() => mockNavbarCubit.state).thenReturn(0); // Start with the first page
    when(() => mockUserBloc.state).thenReturn(UserLogged()); // User is logged in

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: mockNavbarCubit,
          child: BlocProvider.value(
            value: mockUserBloc,
            child: const MainView(),
          ),
        ),
      ),
    );

    // Assert
    expect(find.byType(HomeView), findsOneWidget);
    expect(find.byType(ProfilePengguna), findsNothing);
  });

  testWidgets('MainView displays SignInView when the user is not logged in', (tester) async {
    // Arrange
    when(() => mockNavbarCubit.state).thenReturn(0); // Start with the first page
    when(() => mockUserBloc.state).thenReturn(UserInitial()); // User is not logged in

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: mockNavbarCubit,
          child: BlocProvider.value(
            value: mockUserBloc,
            child: const MainView(),
          ),
        ),
      ),
    );

    // Assert
    expect(find.byType(SignInView), findsOneWidget);
    expect(find.byType(ProfilePengguna), findsNothing);
  });

  testWidgets('MainView navigates between pages when NavbarCubit updates', (tester) async {
    // Arrange
    when(() => mockNavbarCubit.state).thenReturn(0); // Start with the first page
    when(() => mockUserBloc.state).thenReturn(UserLogged());

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: mockNavbarCubit,
          child: BlocProvider.value(
            value: mockUserBloc,
            child: const MainView(),
          ),
        ),
      ),
    );

    // Navigate to second page
    when(() => mockNavbarCubit.state).thenReturn(1);
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(ProfilePengguna), findsOneWidget);
    expect(find.byType(HomeView), findsNothing);
  });
}
