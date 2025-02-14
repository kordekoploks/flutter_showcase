import 'dart:convert';
import 'dart:ffi';

import '../../../domain/entities/category/income_category.dart';
import '../../../domain/entities/category/income_sub_category.dart';
import '../../../domain/entities/category/outcome_category.dart';
import '../../data_sources/local/entity/income_category_entity.dart';
import '../income/income_sub_category_model.dart';


List<IncomeCategoryModel> categoryModelListFromRemoteJson(String str) =>
    List<IncomeCategoryModel>.from(
        json.decode(str)['data'].map((x) => IncomeCategoryModel.fromJson(x)));

List<IncomeCategoryModel> categoryModelListFromLocalJson(String str) =>
    List<IncomeCategoryModel>.from(
        json.decode(str).map((x) => IncomeCategoryModel.fromJson(x)));

String categoryModelListToJson(List<IncomeCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IncomeCategoryModel extends IncomeCategory {
  const IncomeCategoryModel(
      {required String id,
        required int position,
        required String name,
        required String desc,
        required String image,
        List<IncomeSubCategoryModel> subCategories = const []})
      : super(
      id: id,
      position: position,
      name: name,
      desc: desc,
      image: image,
      incomeSubCategory: subCategories);

  factory IncomeCategoryModel.fromJson(Map<String, dynamic> json) =>
      IncomeCategoryModel(
        id: json["_id"],
        position: json["position"],
        name: json["name"],
        desc: json["desc"],
        image: json["image"],
        subCategories: List<IncomeSubCategoryModel>.from(
            json["subCategories"].map((x) => IncomeCategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "position": position,
    "name": name,
    "desc": desc,
    "image": image,
    "subCategories": List<dynamic>.from(
        (IncomeSubCategory as List<IncomeSubCategoryModel>).map((x) => x.toJson())),

  };

  factory IncomeCategoryModel.fromInterface(IncomeCategory entity) =>
      IncomeCategoryModel(
        id: entity.id,
        position: entity.position,
        name: entity.name,
        desc: entity.desc,
        image: entity.image,
        subCategories: entity.incomeSubCategory
            .map((incomeSubCategory) => IncomeSubCategoryModel.fromInterface(incomeSubCategory))
            .toList(),
      );

  factory IncomeCategoryModel.fromEntity(IncomeCategoryEntity entity) =>
      IncomeCategoryModel(
        id: entity.id.toString(),
        position: entity.position!,
        name: entity.name!,
        desc: entity.desc!,
        image: entity.image!,
        subCategories: entity.subCategories
            .map((subCategoryEntity) => IncomeSubCategoryModel.fromEntity(subCategoryEntity))
            .toList(),
      );

  void deleteSubCategoryById(String subCategoryId) {
    incomeSubCategory.removeWhere((subCategory) => subCategory.id == subCategoryId);
  }

  void updateSubCategory(IncomeSubCategoryModel updatedSubCategory) {
    int index = incomeSubCategory.indexWhere((subCategory) => subCategory.id == updatedSubCategory.id);
    if (index != -1) {
      incomeSubCategory[index] = updatedSubCategory;
    }
  }
}
