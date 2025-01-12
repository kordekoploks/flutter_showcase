import 'dart:convert';
import 'dart:ffi';

import 'package:eshop/data/models/account/account_model.dart';
import 'package:eshop/domain/entities/account/Account.dart';
import 'package:eshop/domain/entities/account/account/sub_account.dart';
import 'package:eshop/domain/entities/account/account/sub_account_model.dart';



List<AccountModel> accountModelListFromRemoteJson(String str) =>
    List<AccountModel>.from(
        json.decode(str)['data'].map((x) => AccountModel.fromJson(x)));

List<AccountModel> accountModelListFromLocalJson(String str) =>
    List<AccountModel>.from(
        json.decode(str).map((x) => AccountModel.fromJson(x)));

String accountModelListToJson(List<AccountModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccountModel extends Account {
  const AccountModel(
      {required String id,
        required int position,
        required String name,
        required String desc,
        required String image,
        List<SubAccountModel> subAccount = const []})
      : super(
      id: id,
      position: position,
      name: name,
      desc: desc,
      image: image,
      outcomeSubAccount: subAccount);

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      AccountModel(
        id: json["_id"],
        position: json["position"],
        name: json["name"],
        desc: json["desc"],
        image: json["image"],
        subAccount: List<SubAccountModel>.from(
            json["subCategories"].map((x) => AccountModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "position": position,
    "name": name,
    "desc": desc,
    "image": image,
    "subCategories": List<dynamic>.from(
        (outcomeSubAccount as List<SubAccountModel>).map((x) => x.toJson())),

  };

  factory AccountModel.fromInterface(Account entity) =>
      AccountModel(
        id: entity.id,
        position: entity.position,
        name: entity.name,
        desc: entity.desc,
        image: entity.image,
        subAccount: entity.outcomeSubAccount
            .map((outcomeSubAccount) => SubAccountModel.fromInterface(outcomeSubAccount))
            .toList(),
      );

  factory AccountModel.fromEntity(OutcomeAccountEntity entity) =>
      AccountModel(
        id: entity.id.toString(),
        position: entity.position!,
        name: entity.name!,
        desc: entity.desc!,
        image: entity.image!,
        subAccount: entity.subAccount
            .map((subAccountEntity) => SubAccountModel.fromEntity(subAccountEntity))
            .toList(),
      );

  void deleteSubAccountById(String subAccountId) {
    outcomeSubAccount.removeWhere((subAccount) => subAccount.id == subAccountId);
  }

  void updateSubAccount(SubAccountModel updatedSubAccount) {
    int index = outcomeSubAccount.indexWhere((subCategory) => subCategory.id == updatedSubAccount.id);
    if (index != -1) {
      outcomeSubAccount[index] = updatedSubAccount;
    }
  }
}
