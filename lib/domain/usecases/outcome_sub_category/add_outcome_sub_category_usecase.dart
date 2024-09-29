import 'package:dartz/dartz.dart';
import 'package:eshop/domain/usecases/outcome_sub_category/update_outcome_sub_category_usecase.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../data/models/category/outcome_category_model.dart';
import '../../../data/models/category/outcome_sub_category_model.dart';
import '../../../data/models/user/delivery_info_model.dart';
import '../../entities/category/outcome_category.dart';
import '../../entities/category/outcome_sub_category.dart';
import '../../entities/user/delivery_info.dart';
import '../../repositories/category_repository.dart';
import '../../repositories/delivery_info_repository.dart';
import '../../repositories/outcome_sub_category_repository.dart';

class AddOutcomeSubCategoryUseCase implements UseCase<OutcomeSubCategory, OutcomeSubCategoryUseCaseParams> {
  final OutcomeSubCategoryRepository repository;
  AddOutcomeSubCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, OutcomeSubCategory>> call(OutcomeSubCategoryUseCaseParams params) async {
    return await repository.addData(params);
  }
}
