import 'package:dartz/dartz.dart';
import 'package:eshop/data/models/category/outcome_category_model.dart';

import '../../../../core/error/failures.dart';
import '../entities/category/outcome_category.dart';

abstract class OutcomeCategoryRepository {
  Future<Either<Failure, List<OutcomeCategory>>> getRemoteCategories();

  Future<Either<Failure, List<OutcomeCategory>>> getCachedCategories();

  Future<Either<Failure, List<OutcomeCategory>>> filterCachedCategories(
      String keyword);

  Future<Either<Failure, OutcomeCategory>> addCategories(
      OutcomeCategoryModel keyword);

  Future<Either<Failure, OutcomeCategory>> updateCategory(
      OutcomeCategoryModel keyword);

  Future<Either<Failure, OutcomeCategory>> deleteCategory(
      OutcomeCategory keyword);
}
