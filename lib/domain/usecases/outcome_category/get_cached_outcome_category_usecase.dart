import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/category/outcome_category.dart';
import '../../repositories/outcome_category_repository.dart';

class GetCachedOutcomeCategoryUseCase implements UseCase<List<OutcomeCategory>, NoParams> {
  final OutcomeCategoryRepository repository;
  GetCachedOutcomeCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<OutcomeCategory>>> call(NoParams params) async {
    return await repository.getCachedCategories();
  }
}
