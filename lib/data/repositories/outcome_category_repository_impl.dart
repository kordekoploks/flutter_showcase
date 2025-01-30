import 'package:dartz/dartz.dart';
import 'package:eshop/data/models/category/outcome_category_model.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/repositories/outcome_category_repository.dart';
import '../data_sources/local/outcome_category_local_data_source.dart';
import '../data_sources/remote/category_remote_data_source.dart';

class OutcomeCategoryRepositoryImpl implements OutcomeCategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final OutcomeCategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  OutcomeCategoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<OutcomeCategory>>> getRemoteCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getCategories();
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
  Future<Either<Failure, List<OutcomeCategory>>> getCachedCategories() async {
    try {
      final cachedCategories = await localDataSource.getCategories();
      // if (cachedCategories.isEmpty) await localDataSource.generateCategories();
      final finalData = await localDataSource.getCategories();

      return Right(finalData);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, OutcomeCategory>> addCategories(OutcomeCategoryModel params) async {
    try {
      await localDataSource.saveCategory(params);
      return Right(params);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<OutcomeCategory>>> filterCachedCategories(
      params) async {
    try {
      final filteredCategories = await localDataSource.filterCategories(params);
      return Right(filteredCategories);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, OutcomeCategory>> updateCategory(
      OutcomeCategoryModel keyword) async {
    try {
      await localDataSource.saveCategory(keyword);
      return Right(keyword);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, OutcomeCategory>> deleteCategory(
      OutcomeCategory data) async {
    try {
      await localDataSource.deleteCategory(data);
      return Right(data);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
