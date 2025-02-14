import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../entities/category/income_category.dart';
import '../../../repositories/income_category_repository.dart';

class FilterIncomeCategoryUseCase implements UseCase<List<IncomeCategory>, String> {
  final IncomeCategoryRepository repository;
  FilterIncomeCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<IncomeCategory>>> call(String params) async {
    return await repository.filterCachedCategories(params);
  }
}
