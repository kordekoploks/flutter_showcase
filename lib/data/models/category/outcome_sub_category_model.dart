import 'dart:convert';
import 'dart:ffi';

import 'package:eshop/data/data_sources/local/entity/outcome_sub_category_entity.dart';

import '../../../domain/entities/category/outcome_category.dart';
import '../../../domain/entities/category/outcome_sub_category.dart';

List<OutcomeSubCategoryModel> categoryModelListFromRemoteJson(String str) =>
    List<OutcomeSubCategoryModel>.from(json
        .decode(str)['data']
        .map((x) => OutcomeSubCategoryModel.fromJson(x)));

List<OutcomeSubCategoryModel> categoryModelListFromLocalJson(String str) =>
    List<OutcomeSubCategoryModel>.from(
        json.decode(str).map((x) => OutcomeSubCategoryModel.fromJson(x)));

String categoryModelListToJson(List<OutcomeSubCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OutcomeSubCategoryModel extends OutcomeSubCategory {
  const OutcomeSubCategoryModel(
      {required String id, required String name, required String desc})
      : super(
          id: id,
          name: name,
          desc: desc,
        );

  factory OutcomeSubCategoryModel.fromJson(Map<String, dynamic> json) =>
      OutcomeSubCategoryModel(
        id: json["_id"],
        name: json["name"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "desc": desc,
      };

  factory OutcomeSubCategoryModel.fromInterface(OutcomeSubCategory entity) =>
      OutcomeSubCategoryModel(
        id: entity.id,
        name: entity.name,
        desc: entity.desc,
      );

  factory OutcomeSubCategoryModel.fromEntity(OutcomeSubCategoryEntity entity) =>
      OutcomeSubCategoryModel(
        id: entity.id.toString(),
        name: entity.name.toString(),
        desc: entity.desc.toString(),
      );
}
