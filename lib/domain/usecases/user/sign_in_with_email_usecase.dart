import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/user/user.dart';
import '../../repositories/user_repository.dart';

class SignInWithEmailUseCase implements UseCase<User, SignInWithEmailParams> {
  final UserRepository repository;
  SignInWithEmailUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignInWithEmailParams params) async {
    return await repository.signInWithEmail(params);
  }
}

class SignInWithEmailParams {
  final String email;
  const SignInWithEmailParams({
    required this.email,
  });
}