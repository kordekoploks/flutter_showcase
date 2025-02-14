import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../data/models/category/income_category_model.dart';
import '../../../entities/category/income_category.dart';
import '../../../repositories/income_category_repository.dart';


class UpdateIncomeCategoryUseCase implements UseCase<IncomeCategory, IncomeCategoryModel> {
  final IncomeCategoryRepository repository;
  UpdateIncomeCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, IncomeCategory>> call(IncomeCategoryModel params) async {
    return await repository.updateCategory(params);
  }
}
