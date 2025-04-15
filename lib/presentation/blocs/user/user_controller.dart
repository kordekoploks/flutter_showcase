import 'dart:developer';
import 'package:get/get.dart';
import '../../../core/error/failures.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/user/user.dart';
import '../../../domain/usecases/user/edit_full_name_usecase.dart';
import '../../../domain/usecases/user/edit_usecase.dart';
import '../../../domain/usecases/user/get_cached_user_usecase.dart';
import '../../../domain/usecases/user/sign_in_usecase.dart';
import '../../../domain/usecases/user/sign_out_usecase.dart';
import '../../../domain/usecases/user/sign_up_usecase.dart';

class UserController extends GetxController{
  final GetCachedUserUseCase _getCachedUserUseCase;
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final EditUseCase _editUseCase;
  final EditFullNameUseCase _editFullNameUseCase;

  UserController(
      this._getCachedUserUseCase,
      this._signInUseCase,
      this._signUpUseCase,
      this._signOutUseCase,
      this._editUseCase,
      this._editFullNameUseCase
      );

  var user = Rxn<User>();
  var isLoading = false.obs;
  var failure = Rxn<Failure>();

  Future<void> signIn(SignInParams params) async {
    isLoading.value = true;
    failure.value = null;
    final result = await _signInUseCase(params);
    result.fold(
          (f) => failure.value = f,
          (u) => user.value = u,
    );
    isLoading.value = false;
  }
  Future<void> signUp(SignUpParams params) async {
    isLoading.value = true;
    failure.value = null;
    final result = await _signUpUseCase(params);
    result.fold(
          (f) => failure.value = f,
          (u) => user.value = u,
    );
    isLoading.value = false;
  }
  Future<void> signOut() async {
    isLoading.value = true;
    await _signOutUseCase(NoParams());
    user.value = null;
    isLoading.value = false;
  }
  Future<void> checkUser() async {
    isLoading.value = true;
    failure.value = null;
    final result = await _getCachedUserUseCase(NoParams());
    result.fold(
          (f) => failure.value = f,
          (u) => user.value = u,
    );
    isLoading.value = false;
  }
  Future<void> editUser(EditParams params) async {
    isLoading.value = true;
    failure.value = null;
    final result = await _editUseCase(params);
    result.fold(
          (f) => failure.value = f,
          (u) => user.value = u,
    );
    isLoading.value = false;
  }
  Future<void> editFullName(EditFullNameParams params) async{
    isLoading.value = true;
    failure.value = null;

    try{
      await Future.delayed(const Duration(seconds:10));
      final result = await _editFullNameUseCase(params);
      result.fold(
          (f) => failure.value = f,
          (u) => user.value = u,
      );
    } catch(e) {
      if(e is ServerException) {
        failure.value = ExceptionFailure(e.message);
      }
    }

    await checkUser();
    isLoading.value = false;
  }

}