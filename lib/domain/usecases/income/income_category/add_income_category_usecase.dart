import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../data/models/category/income_category_model.dart';
import '../../../entities/category/income_category.dart';
import '../../../repositories/income_category_repository.dart';

class AddIncomeCategoryUseCase implements UseCase<IncomeCategory, IncomeCategoryModel> {
  final IncomeCategoryRepository repository;
  AddIncomeCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, IncomeCategory>> call(IncomeCategoryModel params) async {
    return await repository.addCategories(params);
  }
}
