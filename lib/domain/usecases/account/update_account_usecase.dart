import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../data/models/account/account_model.dart';
import '../../../data/models/category/outcome_category_model.dart';
import '../../../data/models/user/delivery_info_model.dart';
import '../../entities/account/account.dart';
import '../../entities/category/outcome_category.dart';
import '../../entities/user/delivery_info.dart';
import '../../repositories/account_repository.dart';
import '../../repositories/outcome_category_repository.dart';
import '../../repositories/delivery_info_repository.dart';

class UpdateAccountUseCase implements UseCase<Account, AccountModel> {
  final AccountRepository repository;
  UpdateAccountUseCase(this.repository);

  @override
  Future<Either<Failure, Account>> call(AccountModel params) async {
    return await repository.updateAccount(params);
  }
}
