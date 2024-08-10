import 'dart:convert';
import 'dart:ffi';

import '../../../domain/entities/category/category.dart';

List<CategoryModel> categoryModelListFromRemoteJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str)['data'].map((x) => CategoryModel.fromJson(x)));

List<CategoryModel> categoryModelListFromLocalJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelListToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel extends Category {
  const CategoryModel({
    required String id,
    required int position,
    required String name,
    required String desc,
    required String image,
  }) : super(
          id: id,
          position: position,
          name: name,
          desc: desc,
          image: image,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        position: json["position"],
        name: json["name"],
        desc: json["desc"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "position": position,
        "name": name,
        "desc": desc,
        "image": image,
      };

  factory CategoryModel.fromEntity(Category entity) => CategoryModel(
        id: entity.id,
        position: entity.position,
        name: entity.name,
        desc: entity.desc,
        image: entity.image,
      );
}
