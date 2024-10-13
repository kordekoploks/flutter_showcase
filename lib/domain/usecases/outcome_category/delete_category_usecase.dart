import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/category/outcome_category.dart';
import '../../repositories/category_repository.dart';

class DeleteCategoryUseCase implements UseCase<OutcomeCategory, OutcomeCategory> {
  final CategoryRepository repository;
  DeleteCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, OutcomeCategory>> call(OutcomeCategory params) async {
    return await repository.deleteCategory(params);
  }
}
