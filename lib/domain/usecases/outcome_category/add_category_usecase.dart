import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../data/models/category/outcome_category_model.dart';
import '../../entities/category/outcome_category.dart';
import '../../repositories/category_repository.dart';

class AddCategoryUseCase implements UseCase<OutcomeCategory, OutcomeCategoryModel> {
  final CategoryRepository repository;
  AddCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, OutcomeCategory>> call(OutcomeCategoryModel params) async {
    return await repository.addCategories(params);
  }
}
