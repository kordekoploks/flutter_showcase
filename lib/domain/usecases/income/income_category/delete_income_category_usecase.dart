import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../entities/category/income_category.dart';
import '../../../repositories/income_category_repository.dart';



class DeleteIncomeCategoryUseCase implements UseCase<IncomeCategory, IncomeCategory> {
  final IncomeCategoryRepository repository;
  DeleteIncomeCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, IncomeCategory>> call(IncomeCategory params) async {
    return await repository.deleteCategory(params);
  }
}
