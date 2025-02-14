import 'package:dartz/dartz.dart';


import '../../../../core/error/failures.dart';
import '../entities/category/income_sub_category.dart';
import '../usecases/income/update_income_sub_category_usecase.dart';
abstract class IncomeSubCategoryRepository {

  Future<Either<Failure, List<IncomeSubCategory>>> getCachedData(String  params);

  Future<Either<Failure, List<IncomeSubCategory>>> filterCachedData(
      String keyword);

  Future<Either<Failure, IncomeSubCategory>> addData(
      IncomeSubCategoryUseCaseParams params);

  Future<Either<Failure, IncomeSubCategory>> updateData(
      IncomeSubCategoryUseCaseParams keyword);

  Future<Either<Failure, IncomeSubCategory>> deleteData(
      IncomeSubCategory keyword);
}
