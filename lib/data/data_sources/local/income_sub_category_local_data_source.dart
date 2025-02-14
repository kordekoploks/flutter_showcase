import 'dart:convert';

import 'package:eshop/core/error/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/category/income_sub_category.dart';
import '../../../domain/usecases/income/update_income_sub_category_usecase.dart';
import '../../../objectbox.g.dart';


import '../../models/income/income_sub_category_model.dart';
import 'entity/income_sub_category_entity.dart';


abstract class IncomeSubCategoryLocalDataSource {
  Future<List<IncomeSubCategoryModel>> getSubCategories(String params);

  Future<void> saveCategory(IncomeSubCategoryUseCaseParams data);

  Future<void> deleteCategory(IncomeSubCategory data);

  Future<List<IncomeSubCategoryModel>> filterCategories(String params);
}


class IncomeSubCategoryLocalDataSourceImpl implements IncomeSubCategoryLocalDataSource {
  final Box<IncomeSubCategoryEntity> incomeSubCategoryBox;
  final Store store;

  IncomeSubCategoryLocalDataSourceImpl(
      {required this.incomeSubCategoryBox, required this.store});

  @override
  Future<List<IncomeSubCategoryModel>> getSubCategories(String params) {
    return Future.value(incomeSubCategoryBox
        .query(
        IncomeSubCategoryEntity_.incomeCategory.equals(int.parse(params)))
        .build()
        .find()
        .map((e) => IncomeSubCategoryModel.fromEntity(e))
        .toList());
  }

  @override
  Future<void> saveCategory(IncomeSubCategoryUseCaseParams params) async {
    final categoryEntity = IncomeSubCategoryEntity.fromModel(params.incomeSubCategory, params.incomeCategory);

    await Future.wait([
      incomeSubCategoryBox.putAsync(categoryEntity)
    ]);
  }

  @override
  Future<void> deleteCategory(IncomeSubCategory data) {
    return incomeSubCategoryBox.removeAsync(int.parse(data.id));
  }

  @override
  Future<List<IncomeSubCategoryModel>> filterCategories(String params) {
    return Future.value(incomeSubCategoryBox
        .query(IncomeSubCategoryEntity_.name
        .contains(params, caseSensitive: false))
        .build()
        .find()
        .map((e) => IncomeSubCategoryModel(
        id: e.id.toString(), name: e.name!, desc: e.desc!))
        .toList());
  }
}
