import 'package:dartz/dartz.dart';
import 'package:eshop/data/models/category/outcome_category_model.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/category/outcome_sub_category_model.dart';
import '../entities/category/outcome_category.dart';
import '../entities/category/outcome_sub_category.dart';
import '../usecases/outcome_sub_category/update_outcome_sub_category_usecase.dart';

abstract class OutcomeSubCategoryRepository {

  Future<Either<Failure, List<OutcomeSubCategory>>> getCachedData(String  params);

  Future<Either<Failure, List<OutcomeSubCategory>>> filterCachedData(
      String keyword);

  Future<Either<Failure, OutcomeSubCategory>> addData(
      OutcomeSubCategoryUseCaseParams params);

  Future<Either<Failure, OutcomeSubCategory>> updateData(
      OutcomeSubCategoryUseCaseParams keyword);

  Future<Either<Failure, OutcomeSubCategory>> deleteData(
      OutcomeSubCategory keyword);
}
