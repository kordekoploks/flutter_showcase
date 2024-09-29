import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/category/outcome_category.dart';
import '../../repositories/category_repository.dart';

class FilterCategoryUseCase implements UseCase<List<OutcomeCategory>, String> {
  final CategoryRepository repository;
  FilterCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<OutcomeCategory>>> call(String params) async {
    return await repository.filterCachedCategories(params);
  }
}
