import 'package:dartz/dartz.dart';
import 'package:eshop/data/models/category/outcome_category_model.dart';
import 'package:eshop/domain/entities/account/account.dart';

import '../../../core/error/failures.dart';
import '../../../data/models/account/account_model.dart';

abstract class AccountRepository {

  Future<Either<Failure, List<Account>>> getCachedAccount();

  Future<Either<Failure, List<Account>>> filterCachedAccounts(
      String keyword);

  Future<Either<Failure, Account>> addAccount(
      AccountModel keyword);

  Future<Either<Failure, Account>> updateAccount(
      AccountModel keyword);

  Future<Either<Failure, Account>> deleteAccount(
      Account keyword);
}
