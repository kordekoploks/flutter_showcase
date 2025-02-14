import 'dart:convert';
import 'dart:ffi';

import '../../../domain/entities/category/income_sub_category.dart';
import '../../data_sources/local/entity/income_sub_category_entity.dart';

List<IncomeSubCategoryModel> categoryModelListFromRemoteJson(String str) =>
    List<IncomeSubCategoryModel>.from(json
        .decode(str)['data']
        .map((x) => IncomeSubCategoryModel.fromJson(x)));

List<IncomeSubCategoryModel> categoryModelListFromLocalJson(String str) =>
    List<IncomeSubCategoryModel>.from(
        json.decode(str).map((x) => IncomeSubCategoryModel.fromJson(x)));

String categoryModelListToJson(List<IncomeSubCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IncomeSubCategoryModel extends IncomeSubCategory {
  const IncomeSubCategoryModel(
      {required String id, required String name, required String desc})
      : super(
    id: id,
    name: name,
    desc: desc,
  );

  factory IncomeSubCategoryModel.fromJson(Map<String, dynamic> json) =>
      IncomeSubCategoryModel(
        id: json["_id"],
        name: json["name"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "desc": desc,
  };

  factory IncomeSubCategoryModel.fromInterface(IncomeSubCategory entity) =>
      IncomeSubCategoryModel(
        id: entity.id,
        name: entity.name,
        desc: entity.desc,
      );

  factory IncomeSubCategoryModel.fromEntity(IncomeSubCategoryEntity entity) =>
      IncomeSubCategoryModel(
        id: entity.id.toString(),
        name: entity.name.toString(),
        desc: entity.desc.toString(),
      );
}
