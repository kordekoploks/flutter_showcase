import 'package:dartz/dartz.dart';
import 'package:eshop/domain/usecases/user/edit_full_name_usecase.dart';
import 'package:eshop/domain/usecases/user/edit_usecase.dart';
import '../../../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/user/user.dart';
import '../usecases/user/sign_in_usecase.dart';
import '../usecases/user/sign_up_usecase.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> signIn(SignInParams params);
  Future<Either<Failure, User>> signUp(SignUpParams params);
  Future<Either<Failure, User>> edit(EditParams params);
  Future<Either<Failure, User>> editFullName(EditFullNameParams params);
  Future<Either<Failure, NoParams>> signOut();
  Future<Either<Failure, User>> getCachedUser();
}
