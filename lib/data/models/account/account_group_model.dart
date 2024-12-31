import 'dart:convert';

import '../../../domain/entities/account/AccountGroup.dart';

AccountGroupModel AccountGroupModelFromRemoteJson(String str) =>
    AccountGroupModel.fromJson(json.decode(str)['data']);

AccountGroupModel AccountGroupModelFromLocalJson(String str) =>
    AccountGroupModel.fromJson(json.decode(str));

List<AccountGroupModel> AccountGroupModelListFromRemoteJson(String str) =>
    List<AccountGroupModel>.from(
        json.decode(str)['data'].map((x) => AccountGroupModel.fromJson(x)));

List<AccountGroupModel> AccountGroupModelListFromLocalJson(String str) =>
    List<AccountGroupModel>.from(
        json.decode(str).map((x) => AccountGroupModel.fromJson(x)));

String AccountGroupModelToJson(AccountGroupModel data) =>
    json.encode(data.toJson());

String AccountGroupModelListToJson(List<AccountGroupModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccountGroupModel extends AccountGroup {
  const AccountGroupModel({
    required String id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  factory AccountGroupModel.fromJson(Map<String, dynamic> json) =>
      AccountGroupModel(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };

  factory AccountGroupModel.fromEntity(AccountGroup entity) =>
      AccountGroupModel(
        id: entity.id,
        name: entity.name,
      );
}
