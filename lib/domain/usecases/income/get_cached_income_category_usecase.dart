import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/category/income_category.dart';
import '../../repositories/income_category_repository.dart';
import '../../repositories/outcome_category_repository.dart';

class GetCachedIncomeCategoryUseCase implements UseCase<List<IncomeCategory>, NoParams> {
  final IncomeCategoryRepository repository;
  GetCachedIncomeCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<IncomeCategory>>> call(NoParams params) async {
    return await repository.getCachedCategories();
  }
}
