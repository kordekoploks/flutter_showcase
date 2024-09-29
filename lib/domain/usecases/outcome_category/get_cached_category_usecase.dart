import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/category/outcome_category.dart';
import '../../repositories/category_repository.dart';

class GetCachedCategoryUseCase implements UseCase<List<OutcomeCategory>, NoParams> {
  final CategoryRepository repository;
  GetCachedCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<OutcomeCategory>>> call(NoParams params) async {
    return await repository.getCachedCategories();
  }
}
