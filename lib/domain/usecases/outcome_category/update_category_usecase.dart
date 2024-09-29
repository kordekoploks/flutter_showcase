import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../data/models/category/outcome_category_model.dart';
import '../../../data/models/user/delivery_info_model.dart';
import '../../entities/category/outcome_category.dart';
import '../../entities/user/delivery_info.dart';
import '../../repositories/category_repository.dart';
import '../../repositories/delivery_info_repository.dart';

class UpdateCategoryUseCase implements UseCase<OutcomeCategory, OutcomeCategoryModel> {
  final CategoryRepository repository;
  UpdateCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, OutcomeCategory>> call(OutcomeCategoryModel params) async {
    return await repository.updateCategory(params);
  }
}
