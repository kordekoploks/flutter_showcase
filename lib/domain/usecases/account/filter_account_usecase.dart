import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/account/account.dart';
import '../../entities/category/outcome_category.dart';
import '../../repositories/account_repository.dart';
import '../../repositories/outcome_category_repository.dart';

class FilterAccountUseCase implements UseCase<List<Account>, String> {
  final AccountRepository repository;
  FilterAccountUseCase(this.repository);

  @override
  Future<Either<Failure, List<Account>>> call(String params) async {
    return await repository.filterCachedAccounts(params);
  }
}
