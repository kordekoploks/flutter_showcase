import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/account/account.dart';
import '../../entities/category/outcome_category.dart';
import '../../repositories/account_repository.dart';
import '../../repositories/category_repository.dart';

class DeleteAccountUseCase implements UseCase<Account, Account> {
  final AccountRepository repository;
  DeleteAccountUseCase(this.repository);

  @override
  Future<Either<Failure, Account>> call(Account params) async {
    return await repository.deleteAccount(params);
  }
}
