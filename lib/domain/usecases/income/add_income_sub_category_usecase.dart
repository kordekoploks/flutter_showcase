import 'package:dartz/dartz.dart';
import 'package:eshop/domain/usecases/income/update_income_sub_category_usecase.dart';
import 'package:eshop/domain/usecases/outcome_sub_category/update_outcome_sub_category_usecase.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../data/models/category/outcome_category_model.dart';
import '../../../data/models/category/outcome_sub_category_model.dart';
import '../../../data/models/user/delivery_info_model.dart';
import '../../entities/category/income_sub_category.dart';
import '../../entities/category/outcome_category.dart';
import '../../entities/category/outcome_sub_category.dart';
import '../../entities/user/delivery_info.dart';
import '../../repositories/income_sub_category_repository.dart';
import '../../repositories/outcome_category_repository.dart';
import '../../repositories/delivery_info_repository.dart';
import '../../repositories/outcome_sub_category_repository.dart';

class AddIncomeSubCategoryUseCase implements UseCase<IncomeSubCategory, IncomeSubCategoryUseCaseParams> {
  final IncomeSubCategoryRepository repository;
  AddIncomeSubCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, IncomeSubCategory>> call(IncomeSubCategoryUseCaseParams params) async {
    return await repository.addData(params);
  }
}
