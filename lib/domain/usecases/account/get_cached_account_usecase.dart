import 'package:dartz/dartz.dart';
import 'package:eshop/domain/entities/account/account.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/account_repository.dart';


class GetCachedAccountUseCase implements UseCase<List<Account>, NoParams> {
  final AccountRepository repository;
  GetCachedAccountUseCase(this.repository);

  @override
  Future<Either<Failure, List<Account>>> call(NoParams params) async {
    return await repository.getCachedAccount();
  }
}
