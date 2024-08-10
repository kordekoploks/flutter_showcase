import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../data/models/category/category_model.dart';
import '../../../data/models/user/delivery_info_model.dart';
import '../../entities/category/category.dart';
import '../../entities/user/delivery_info.dart';
import '../../repositories/category_repository.dart';
import '../../repositories/delivery_info_repository.dart';

class AddCategoryUseCase implements UseCase<List<Category>, CategoryModel> {
  final CategoryRepository repository;
  AddCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(CategoryModel params) async {
    return await repository.addCategories(params);
  }
}
