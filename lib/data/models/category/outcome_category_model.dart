import 'dart:convert';
import 'dart:ffi';

import '../../../domain/entities/category/outcome_category.dart';
import '../../data_sources/local/entity/outcome_category_entity.dart';
import 'outcome_sub_category_model.dart';

List<OutcomeCategoryModel> categoryModelListFromRemoteJson(String str) =>
    List<OutcomeCategoryModel>.from(
        json.decode(str)['data'].map((x) => OutcomeCategoryModel.fromJson(x)));

List<OutcomeCategoryModel> categoryModelListFromLocalJson(String str) =>
    List<OutcomeCategoryModel>.from(
        json.decode(str).map((x) => OutcomeCategoryModel.fromJson(x)));

String categoryModelListToJson(List<OutcomeCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OutcomeCategoryModel extends OutcomeCategory {
  const OutcomeCategoryModel(
      {required String id,
      required int position,
      required String name,
      required String desc,
      required String image,
      List<OutcomeSubCategoryModel> subCategories = const []})
      : super(
            id: id,
            position: position,
            name: name,
            desc: desc,
            image: image,
            outcomeSubCategory: subCategories);


  factory OutcomeCategoryModel.fromJson(Map<String, dynamic> json) =>
      OutcomeCategoryModel(
        id: json["_id"],
        position: json["position"],
        name: json["name"],
        desc: json["desc"],
        image: json["image"],
        subCategories: List<OutcomeSubCategoryModel>.from(
            json["subCategories"].map((x) => OutcomeCategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "position": position,
        "name": name,
        "desc": desc,
        "image": image,
        "subCategories": List<dynamic>.from(
        (outcomeSubCategory as List<OutcomeSubCategoryModel>).map((x) => x.toJson())),

  };

  factory OutcomeCategoryModel.fromInterface(OutcomeCategory entity) =>
      OutcomeCategoryModel(
        id: entity.id,
        position: entity.position,
        name: entity.name,
        desc: entity.desc,
        image: entity.image,
        subCategories: entity.outcomeSubCategory
            .map((outcomeSubCategory) => OutcomeSubCategoryModel.fromInterface(outcomeSubCategory))
            .toList(),
      );

  factory OutcomeCategoryModel.fromEntity(OutcomeCategoryEntity entity) =>
      OutcomeCategoryModel(
        id: entity.id.toString(),
        position: entity.position!,
        name: entity.name!,
        desc: entity.desc!,
        image: entity.image!,
        subCategories: entity.subCategories
            .map((subCategoryEntity) => OutcomeSubCategoryModel.fromEntity(subCategoryEntity))
            .toList(),
      );

  void deleteSubCategoryById(String subCategoryId) {
    outcomeSubCategory.removeWhere((subCategory) => subCategory.id == subCategoryId);
  }

  void updateSubCategory(OutcomeSubCategoryModel updatedSubCategory) {
    int index = outcomeSubCategory.indexWhere((subCategory) => subCategory.id == updatedSubCategory.id);
    if (index != -1) {
      outcomeSubCategory[index] = updatedSubCategory;
    }
  }
}
