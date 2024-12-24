import 'dart:ffi';
import 'dart:ffi';

import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/user/user.dart';
import '../../repositories/user_repository.dart';
import 'package:eshop/domain/usecases/user/sign_up_usecase.dart';

//user adalah hasil dari data source entah dari server atau dari local
class EditUseCase implements UseCase<User, EditParams> {
  final UserRepository repository;

  EditUseCase(this.repository);

  //kode yang di eksekusi
  //kalau gagal dia munculkan object failure
  //kalau berhasil munculkan object user
  @override
  Future<Either<Failure, User>> call(EditParams params) async {
    return await repository.edit(params);
  }
}

class EditParams extends SignUpParams {
  final String id;

  EditParams({
    required this.id,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.email,
    required super.password,
  });
}

//data yang di perlukan untuk melakukan registrasi

//buat edit/update usecase tapi tidak pakai params
