import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eshop/core/error/exceptions.dart';
import 'package:eshop/domain/usecases/user/sign_out_usecase.dart';
import 'package:eshop/domain/usecases/user/sign_up_usecase.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../data/models/setting/setting_model.dart';
import '../../../domain/entities/setting/setting.dart';
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
  //buat edit/update usecase

  UserBloc(
    this._getCachedUserUseCase,
    this._signInUseCase,
    this._signUpUseCase,
    this._signOutUseCase,
    this._editUseCase,
    //buat this. edit/update usecase
   ) : super(UserInitial()) {
    on<SignInUser>(_onSignIn);
    on<SignUpUser>(_onSignUp);
    on<CheckUser>(_onCheckUser);
    on<SignOutUser>(_onSignOut);
    on<EditUser>(_onEdit);
    //buat user initial edit/update
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
      final result = await _getCachedUserUseCase(NoParams());
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserLogged(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
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
      //emit dilakukan memanggil state untuk berkomunikasi dengan ui
      emit(UserLoading());
      final result = await _editUseCase(event.params);
      result.fold(
            (failure) => emit(UserEditFail(failure)),
            (user) => emit(UserLogged(user)),
      );
    } catch (e) {
      if(e is ServerException) {
        emit(UserEditFail(ExceptionFailure(e.message)));
      }
    }
  }
//copy dan ganti jadi edit/update, ganti user loged


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
