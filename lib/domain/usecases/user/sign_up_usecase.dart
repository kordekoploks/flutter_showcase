import 'dart:ffi';
import 'dart:ffi';

import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/user/user.dart';
import '../../repositories/user_repository.dart';

//user adalah hasil dari data source entah dari server atau dari local
class SignUpUseCase implements UseCase<User, SignUpParams> {
  final UserRepository repository;
  SignUpUseCase(this.repository);

  //kode yang di eksekusi
  //kalau gagal dia munculkan object failure
  //kalau berhasil munculkan object user
  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await repository.signUp(params);
  }
}

//data yang di perlukan untuk melakukan registrasi
class SignUpParams {
  final String firstName;
  final String lastName;
  final int phoneNumber;
  final String email;
  final String password;
  const SignUpParams({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });
}
//buat edit/update usecase tapi tidak pakai params