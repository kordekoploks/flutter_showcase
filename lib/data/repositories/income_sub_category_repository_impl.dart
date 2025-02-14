import 'package:dartz/dartz.dart';
import 'package:eshop/data/data_sources/local/outcome_sub_category_local_data_source.dart';
import 'package:eshop/data/models/category/outcome_category_model.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:eshop/domain/entities/category/outcome_sub_category.dart';
import 'package:eshop/domain/repositories/outcome_sub_category_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/category/income_sub_category.dart';
import '../../domain/repositories/income_sub_category_repository.dart';
import '../../domain/repositories/outcome_category_repository.dart';
import '../../domain/usecases/income/update_income_sub_category_usecase.dart';
import '../../domain/usecases/outcome_sub_category/update_outcome_sub_category_usecase.dart';
import '../data_sources/local/income_sub_category_local_data_source.dart';
import '../data_sources/local/outcome_category_local_data_source.dart';
import '../data_sources/remote/outcome_category_remote_data_source.dart';
import '../models/category/outcome_sub_category_model.dart';

class IncomeSubCategoryRepositoryImpl implements IncomeSubCategoryRepository {
  final IncomeSubCategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  IncomeSubCategoryRepositoryImpl({
    required this.localDataSource,
    required this.networkInfo,
  });


  @override
  Future<Either<Failure, List<IncomeSubCategory>>> getCachedData(String params) async {
    try {
      final cachedCategories = await localDataSource.getSubCategories(params);
      return Right(cachedCategories);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, IncomeSubCategory>> addData(IncomeSubCategoryUseCaseParams params) async {
    try {
      await localDataSource.saveCategory(params);
      return Right(params.incomeSubCategory);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<IncomeSubCategory>>> filterCachedData(params) async {
    try {
      final filteredCategories = await localDataSource.filterCategories(params);
      return Right(filteredCategories);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, IncomeSubCategory>> updateData(
      IncomeSubCategoryUseCaseParams params) async {
    try {
      await localDataSource.saveCategory(params);
      return Right(params.incomeSubCategory);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, IncomeSubCategory>> deleteData(
      IncomeSubCategory data) async {
    try {
      await localDataSource.deleteCategory(data);
      return Right(data);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
