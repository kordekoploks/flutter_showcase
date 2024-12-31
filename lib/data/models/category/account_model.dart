import 'dart:convert';
import 'dart:ffi';

import 'package:eshop/domain/entities/account/AccountGroup.dart';

import '../../../domain/entities/account/Account.dart';
import '../../../domain/entities/category/outcome_category.dart';
import '../../data_sources/local/entity/outcome_category_entity.dart';
import 'outcome_sub_category_model.dart';

List<AccountModel> categoryModelListFromRemoteJson(String str) =>
    List<AccountModel>.from(
        json.decode(str)['data'].map((x) => AccountModel.fromJson(x)));

List<AccountModel> categoryModelListFromLocalJson(String str) =>
    List<AccountModel>.from(
        json.decode(str).map((x) => AccountModel.fromJson(x)));

String categoryModelListToJson(List<AccountModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccountModel extends Account {
  const AccountModel(
      {required String id,
      required String name,
      required String desc,
      required AccountGroup accountGroup})
      : super(
            id: id,
            name: name,
            desc: desc,
            accountGroup: accountGroup);

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        id: json["_id"],
        name: json["name"],
        desc: json["desc"],
        accountGroup: List<OutcomeSubCategoryModel>.from(
            json["subCategories"].map((x) => AccountModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "position": position,
        "name": name,
        "desc": desc,
        "image": image,
        "subCategories": List<dynamic>.from(
            (accountGroup as List<OutcomeSubCategoryModel>)
                .map((x) => x.toJson())),
      };

  factory AccountModel.fromInterface(Account entity) => AccountModel(
        id: entity.id,
        position: entity.position,
        name: entity.name,
        desc: entity.desc,
        image: entity.image,
        accountGroup: entity.accountGroup
            .map((outcomeSubCategory) =>
                OutcomeSubCategoryModel.fromInterface(outcomeSubCategory))
            .toList(),
      );

  factory AccountModel.fromEntity(AccountEntity entity) => AccountModel(
        id: entity.id.toString(),
        position: entity.position!,
        name: entity.name!,
        desc: entity.desc!,
        image: entity.image!,
        accountGroup: entity.subCategories
            .map((subCategoryEntity) =>
                OutcomeSubCategoryModel.fromEntity(subCategoryEntity))
            .toList(),
      );

  void deleteSubCategoryById(String subCategoryId) {
    accountGroup.removeWhere((subCategory) => subCategory.id == subCategoryId);
  }

  void updateSubCategory(OutcomeSubCategoryModel updatedSubCategory) {
    int index = accountGroup
        .indexWhere((subCategory) => subCategory.id == updatedSubCategory.id);
    if (index != -1) {
      accountGroup[index] = updatedSubCategory;
    }
  }
}
