import 'dart:ffi';
import 'dart:ffi';

import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/user/user.dart';
import '../../repositories/user_repository.dart';
import 'package:eshop/domain/usecases/user/sign_up_usecase.dart';

//user adalah hasil dari data source entah dari server atau dari local
class EditFullNameUseCase implements UseCase<User, EditFullNameParams> {
  final UserRepository repository;

  EditFullNameUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(EditFullNameParams params) async {
    return await repository.editFullName(params);
  }
}

class EditFullNameParams  {
  final String id;
  final String firstName;
  final String lastName;

  EditFullNameParams({
    required this.id,
    required this.firstName,
    required this.lastName,
   });
}

//data yang di perlukan untuk melakukan registrasi

//buat edit/update usecase tapi tidak pakai params
