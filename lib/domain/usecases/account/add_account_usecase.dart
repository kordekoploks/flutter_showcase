import 'package:dartz/dartz.dart';
import 'package:eshop/domain/entities/account/account.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../data/models/account/account_model.dart';
import '../../repositories/account_repository.dart';


class AddAccountUseCase implements UseCase<Account, AccountModel> {
  final AccountRepository repository;
  AddAccountUseCase(this.repository);

  @override
  Future<Either<Failure, Account>> call(AccountModel params) async {
    return await repository.addAccount(params);
  }
}
