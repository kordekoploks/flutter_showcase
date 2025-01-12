import 'dart:convert';
import 'dart:ffi';

import 'package:eshop/data/data_sources/local/entity/outcome_sub_category_entity.dart';
import 'package:eshop/domain/entities/account/account/sub_account.dart';


List<SubAccountModel> accountModelListFromRemoteJson(String str) =>
    List<SubAccountModel>.from(json
        .decode(str)['data']
        .map((x) => SubAccountModel.fromJson(x)));

List<SubAccountModel> accountModelListFromLocalJson(String str) =>
    List<SubAccountModel>.from(
        json.decode(str).map((x) => SubAccountModel.fromJson(x)));

String accountModelListToJson(List<SubAccountModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubAccountModel extends SubAccount {
  const SubAccountModel(
      {required String id, required String name, required String desc})
      : super(
    id: id,
    name: name,
    desc: desc,
  );

  factory SubAccountModel.fromJson(Map<String, dynamic> json) =>
      SubAccountModel(
        id: json["_id"],
        name: json["name"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "desc": desc,
  };

  factory SubAccountModel.fromInterface(SubAccount entity) =>
      SubAccountModel(
        id: entity.id,
        name: entity.name,
        desc: entity.desc,
      );

  factory SubAccountModel.fromEntity(OutcomeSubCategoryEntity entity) =>
      SubAccountModel(
        id: entity.id.toString(),
        name: entity.name.toString(),
        desc: entity.desc.toString(),
      );
}
