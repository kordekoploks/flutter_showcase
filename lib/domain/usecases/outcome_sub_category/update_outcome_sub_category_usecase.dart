import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../data/models/category/outcome_sub_category_model.dart';
import '../../entities/category/outcome_sub_category.dart';
import '../../repositories/outcome_sub_category_repository.dart';

class UpdateOutcomeSubCategoryUseCase
    implements
        UseCase<OutcomeSubCategory, OutcomeSubCategoryUseCaseParams> {
  final OutcomeSubCategoryRepository repository;

  UpdateOutcomeSubCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, OutcomeSubCategory>> call(
      OutcomeSubCategoryUseCaseParams params) async {
    return await repository.updateData(params);
  }
}

class OutcomeSubCategoryUseCaseParams extends Equatable {
  final OutcomeSubCategory outcomeSubCategory;
  final OutcomeCategory outcomeCategory;

  const OutcomeSubCategoryUseCaseParams({
    required this.outcomeSubCategory,
    required this.outcomeCategory,
  });

  @override
  List<Object?> get props => [id];
}
