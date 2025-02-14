import 'package:dartz/dartz.dart';
import 'package:eshop/data/models/category/outcome_sub_category_model.dart';
import 'package:eshop/domain/repositories/outcome_sub_category_repository.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../data/models/category/outcome_category_model.dart';
import '../../../data/models/user/delivery_info_model.dart';
import '../../entities/category/income_sub_category.dart';
import '../../entities/category/outcome_category.dart';
import '../../entities/category/outcome_sub_category.dart';
import '../../entities/user/delivery_info.dart';
import '../../repositories/income_sub_category_repository.dart';
import '../../repositories/outcome_category_repository.dart';
import '../../repositories/delivery_info_repository.dart';

class DeleteIncomeSubCategoryUseCase implements UseCase<IncomeSubCategory, IncomeSubCategory> {
  final IncomeSubCategoryRepository repository;
  DeleteIncomeSubCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, IncomeSubCategory>> call(IncomeSubCategory params) async {
    return await repository.deleteData(params);
  }
}
