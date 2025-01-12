import 'package:dartz/dartz.dart';
import 'package:eshop/data/models/category/outcome_category_model.dart';
import 'package:eshop/domain/entities/account/Account.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../../../data/data_sources/local/account_local_data_source.dart';
import '../../../../data/models/account/account_model.dart';
import 'account_remote_data_source.dart';
import 'account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource remoteDataSource;
  final AccountLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AccountRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Account>>> getRemoteAccount() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAccount();
        localDataSource.saveCategories(remoteProducts);
        return Right(remoteProducts);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Account>>> getCachedAccount() async {
    try {
      final cachedAccount = await localDataSource.getAccount();
      // if (cachedCategories.isEmpty) await localDataSource.generateCategories();
      final finalData = await localDataSource.getAccount();

      return Right(finalData);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure,Account>> addAccount(AccountModel params) async {
    try {
      await localDataSource.saveAccount(params);
      return Right(params);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Account>>> filterCachedAccount(
      params) async {
    try {
      final filteredAccount = await localDataSource.filterAccount(params);
      return Right(filteredAccount);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Account>> updateAccount(
      AccountModel keyword) async {
    try {
      await localDataSource.saveAccount(keyword);
      return Right(keyword);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Account>> deleteAccount(
      Account data) async {
    try {
      await localDataSource.deleteAccount(data);
      return Right(data);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
