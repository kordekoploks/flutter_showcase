import 'package:dartz/dartz.dart';
import 'package:eshop/data/models/category/category_model.dart';

import '../../../../core/error/failures.dart';
import '../entities/category/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getRemoteCategories();
  Future<Either<Failure, List<Category>>> getCachedCategories();
  Future<Either<Failure, List<Category>>> filterCachedCategories(String keyword);
  Future<Either<Failure, List<Category>>> addCategories(CategoryModel keyword);
  Future<Either<Failure, List<Category>>> updateCategory(CategoryModel keyword);
  Future<Either<Failure, List<Category>>> deleteCategory(CategoryModel keyword);
}
