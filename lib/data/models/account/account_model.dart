import 'dart:convert';
import 'dart:ffi';

import 'package:eshop/data/data_sources/local/entity/AccountEntity.dart';

import '../../../domain/entities/account/Account.dart';


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
      required String name,
      required String desc,
      required Long initialAmt,
      required String accountGroup})
      : super(
            id: id,
            name: name,
            desc: desc,
            initialAmt: initialAmt,
            accountGroup: accountGroup);

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
      id: json["_id"],
      name: json["name"],
      desc: json["desc"],
      initialAmt: json["initialAmt"],
      accountGroup: json["accountGroup"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "desc": desc,
        "initialAmt": initialAmt,
        "accountGroup": accountGroup,
      };

  factory AccountModel.fromInterface(Account entity) => AccountModel(
        id: entity.id,
        name: entity.name,
        desc: entity.desc,
        initialAmt: entity.initialAmt,
        accountGroup: entity.accountGroup!,
      );

  factory AccountModel.fromEntity(AccountEntity entity) => AccountModel(
      id: entity.id.toString(),
      name: entity.name!,
      desc: entity.desc!,
      initialAmt: entity.initialAmt!,
      accountGroup: entity.accountGroup!);
}
