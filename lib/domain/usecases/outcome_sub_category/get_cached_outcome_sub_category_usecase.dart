import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/category/outcome_sub_category.dart';
import '../../repositories/outcome_sub_category_repository.dart';

class GetCachedOutcomeSubCategoryUseCase implements UseCase<List<OutcomeSubCategory>, String> {
  final OutcomeSubCategoryRepository repository;
  GetCachedOutcomeSubCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<OutcomeSubCategory>>> call(String params) async {
    return await repository.getCachedData(params);
  }
}
