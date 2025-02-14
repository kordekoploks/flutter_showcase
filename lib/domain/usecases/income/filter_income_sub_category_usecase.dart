import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/category/income_sub_category.dart';
import '../../entities/category/outcome_sub_category.dart';
import '../../repositories/income_sub_category_repository.dart';
import '../../repositories/outcome_sub_category_repository.dart';

class FilterIncomeSubCategoryUseCase implements UseCase<List<IncomeSubCategory>, String> {
  final IncomeSubCategoryRepository repository;
  FilterIncomeSubCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<IncomeSubCategory>>> call(String params) async {
    return await repository.filterCachedData(params);
  }
}
