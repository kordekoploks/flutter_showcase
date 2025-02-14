import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/category/income_category.dart';
import '../../entities/category/income_sub_category.dart';
import '../../repositories/income_sub_category_repository.dart';

class UpdateIncomeSubCategoryUseCase
    implements
        UseCase<IncomeSubCategory, IncomeSubCategoryUseCaseParams> {
  final IncomeSubCategoryRepository repository;

  UpdateIncomeSubCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, IncomeSubCategory>> call(
      IncomeSubCategoryUseCaseParams params) async {
    return await repository.updateData(params);
  }
}

class IncomeSubCategoryUseCaseParams extends Equatable {
  final IncomeSubCategory incomeSubCategory;
  final IncomeCategory incomeCategory;

  const IncomeSubCategoryUseCaseParams({
    required this.incomeSubCategory,
    required this.incomeCategory,
  });

  @override
  List<Object?> get props => [id];
}
