import 'package:dartz/dartz.dart';
import 'package:eshop/data/data_sources/local/outcome_sub_category_local_data_source.dart';
import 'package:eshop/data/models/category/outcome_category_model.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:eshop/domain/entities/category/outcome_sub_category.dart';
import 'package:eshop/domain/repositories/outcome_sub_category_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/repositories/outcome_category_repository.dart';
import '../../domain/usecases/outcome_sub_category/update_outcome_sub_category_usecase.dart';
import '../data_sources/local/outcome_category_local_data_source.dart';
import '../data_sources/remote/category_remote_data_source.dart';
import '../models/category/outcome_sub_category_model.dart';

class OutcomeSubCategoryRepositoryImpl implements OutcomeSubCategoryRepository {
  final OutcomeSubCategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  OutcomeSubCategoryRepositoryImpl({
    required this.localDataSource,
    required this.networkInfo,
  });


  @override
  Future<Either<Failure, List<OutcomeSubCategory>>> getCachedData(String params) async {
    try {
      final cachedCategories = await localDataSource.getSubCategories(params);
      return Right(cachedCategories);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, OutcomeSubCategory>> addData(OutcomeSubCategoryUseCaseParams params) async {
    try {
      await localDataSource.saveCategory(params);
      return Right(params.outcomeSubCategory);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<OutcomeSubCategory>>> filterCachedData(params) async {
    try {
      final filteredCategories = await localDataSource.filterCategories(params);
      return Right(filteredCategories);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, OutcomeSubCategory>> updateData(
      OutcomeSubCategoryUseCaseParams params) async {
    try {
      await localDataSource.saveCategory(params);
      return Right(params.outcomeSubCategory);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, OutcomeSubCategory>> deleteData(
      OutcomeSubCategory data) async {
    try {
      await localDataSource.deleteCategory(data);
      return Right(data);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
