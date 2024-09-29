import 'dart:convert';

import 'package:eshop/core/error/failures.dart';
import 'package:eshop/data/data_sources/local/entity/outcome_category_entity.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/category/outcome_sub_category.dart';
import '../../../domain/usecases/outcome_sub_category/update_outcome_sub_category_usecase.dart';
import '../../../objectbox.g.dart';
import '../../models/category/outcome_category_model.dart';
import '../../models/category/outcome_sub_category_model.dart';
import 'entity/outcome_category_entity.dart';
import 'entity/outcome_sub_category_entity.dart';

abstract class OutcomeSubCategoryLocalDataSource {
  Future<List<OutcomeSubCategoryModel>> getSubCategories(String params);

  Future<void> saveCategory(OutcomeSubCategoryUseCaseParams data);

  Future<void> deleteCategory(OutcomeSubCategory data);

  Future<List<OutcomeSubCategoryModel>> filterCategories(String params);
}


class OutcomeSubCategoryLocalDataSourceImpl implements OutcomeSubCategoryLocalDataSource {
  final Box<OutcomeSubCategoryEntity> outcomeSubCategoryBox;
  final Store store;

  OutcomeSubCategoryLocalDataSourceImpl(
      {required this.outcomeSubCategoryBox, required this.store});

  @override
  Future<List<OutcomeSubCategoryModel>> getSubCategories(String params) {
    return Future.value(outcomeSubCategoryBox
        .query(
            OutcomeSubCategoryEntity_.outcomeCategory.equals(int.parse(params)))
        .build()
        .find()
        .map((e) => OutcomeSubCategoryModel.fromEntity(e))
        .toList());
  }

  @override
  Future<void> saveCategory(OutcomeSubCategoryUseCaseParams params) async {
    final categoryEntity = OutcomeSubCategoryEntity.fromModel(params.outcomeSubCategory, params.outcomeCategory);

    await Future.wait([
      outcomeSubCategoryBox.putAsync(categoryEntity)
    ]);
  }

  @override
  Future<void> deleteCategory(OutcomeSubCategory data) {
    return outcomeSubCategoryBox.removeAsync(int.parse(data.id));
  }

  @override
  Future<List<OutcomeSubCategoryModel>> filterCategories(String params) {
    return Future.value(outcomeSubCategoryBox
        .query(OutcomeSubCategoryEntity_.name
            .contains(params, caseSensitive: false))
        .build()
        .find()
        .map((e) => OutcomeSubCategoryModel(
            id: e.id.toString(), name: e.name!, desc: e.desc!))
        .toList());
  }
}
