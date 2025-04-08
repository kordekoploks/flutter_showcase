import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eshop/core/error/exceptions.dart';
import 'package:eshop/domain/usecases/user/edit_full_name_usecase.dart';
import 'package:eshop/domain/usecases/user/sign_out_usecase.dart';
import 'package:eshop/domain/usecases/user/sign_up_usecase.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/user/user.dart';
import '../../../domain/usecases/user/edit_usecase.dart';
import '../../../domain/usecases/user/get_cached_user_usecase.dart';
import '../../../domain/usecases/user/sign_in_usecase.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCachedUserUseCase _getCachedUserUseCase;
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final EditUseCase _editUseCase;
  final EditFullNameUseCase _editFullNameUseCase;

  UserBloc(
    this._getCachedUserUseCase,
    this._signInUseCase,
    this._signUpUseCase,
    this._signOutUseCase,
    this._editUseCase,
    this._editFullNameUseCase,
  ) : super(UserInitial()) {
    on<SignInUser>(_onSignIn);
    on<SignUpUser>(_onSignUp);
    on<CheckUser>(_onCheckUser);
    on<SignOutUser>(_onSignOut);
    on<EditUser>(_onEdit);
    on<EditFullNameUser>(_onEditFullName);
  }

  void _onSignIn(SignInUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signInUseCase(event.params);
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserLogged(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  void _onCheckUser(CheckUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      checkUser();
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  void checkUser() async {
    final result = await _getCachedUserUseCase(NoParams());
    result.fold(
      (failure) => emit(UserLoggedFail(failure)),
      (user) => emit(UserLogged(user)),
    );
  }

  FutureOr<void> _onSignUp(SignUpUser event, Emitter<UserState> emit) async {
    try {
      //emit dilakukan memanggil state untuk berkomunikasi dengan ui
      emit(UserLoading());
      final result = await _signUpUseCase(event.params);
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserLogged(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  FutureOr<void> _onEdit(EditUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _editUseCase(event.params);
      result.fold(
        (failure) => emit(UserEditFail(failure)),
        (user) => emit(UserLogged(user)),
      );
    } catch (e) {
      if (e is ServerException) {
        log(e.message);
        emit(UserEditFail(ExceptionFailure(e.message)));
      }
    }
  }

  FutureOr<void> _onEditFullName(
      EditFullNameUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      await Future.delayed(const Duration(seconds: 10));
      final result = await _editFullNameUseCase(event.params);
      result.fold(
        (failure) => emit(UserEditFail(failure)),
        (user) {
          emit(UserEdited(user));

        },
      );
    } catch (e) {
      if (e is ServerException) {
        emit(UserEditFail(ExceptionFailure(e.message)));
      }
    }
    checkUser();

  }

  void _onSignOut(SignOutUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      await _signOutUseCase(NoParams());
      emit(UserLoggedOut());
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }
}
