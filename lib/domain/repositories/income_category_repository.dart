import 'package:dartz/dartz.dart';
import 'package:eshop/data/models/category/income_category_model.dart';

import '../../../../core/error/failures.dart';
import '../entities/category/income_category.dart';

abstract class IncomeCategoryRepository {
  Future<Either<Failure, List<IncomeCategory>>> getRemoteCategories();

  Future<Either<Failure, List<IncomeCategory>>> getCachedCategories();

  Future<Either<Failure, List<IncomeCategory>>> filterCachedCategories(
      String keyword);

  Future<Either<Failure, IncomeCategory>> addCategories(
      IncomeCategoryModel keyword);

  Future<Either<Failure, IncomeCategory>> updateCategory(
      IncomeCategoryModel keyword);

  Future<Either<Failure, IncomeCategory>> deleteCategory(
      IncomeCategory keyword);
}
