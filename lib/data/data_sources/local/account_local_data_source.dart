import 'dart:convert';

import 'package:eshop/core/error/failures.dart';
import 'package:eshop/data/data_sources/local/entity/outcome_category_entity.dart';
import 'package:eshop/domain/entities/account/Account.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/account/account/account_model.dart';
import '../../../objectbox.g.dart';
import '../../models/category/outcome_category_model.dart';
import 'entity/outcome_category_entity.dart';
import 'entity/outcome_sub_category_entity.dart';

abstract class AccountLocalDataSource {
  Future<List<AccountModel>> getAccount();

  Future<void> saveAccount(AccountModel accountModel);

  Future<void> deleteAccount(Account accountModel);

  Future<void> saveAccount(List<AccountModel> accountToCache);

  Future<void> generateAccount();

  Future<List<AccountModel>> filterAccount(String params);
}

const cachedAccount = 'CACHED_ACCOUNT';

class AccountLocalDataSourceImpl implements AccountLocalDataSource {
  final Box<AccountCategoryEntity> AccountBox;
  final Box<AccountSubCategoryEntity> accountSubCategoryBox;
  final Store store;

  AccountLocalDataSourceImpl(
      {required this.accountSubCategoryBox,
        required this.accountSubCategoryBox,
        required this.store});

  @override
  Future<List<AccountModel>> getAccount() {
    return Future.value(accountBox
        .getAll()
        .map((e) => AccountModel.fromEntity(e))
        .toList());
  }

  @override
  Future<void> saveAccout(AccountModel e) async {
    final accountEntity = AccountEntity.fromModel(e);

    final newSubAccountIds = e.SubAccount.map((sub) => sub.id).toSet();

    final idsToDelete = accountEntity.subAccount
        .where((sub) => !newSubAccountIds.contains(sub.id))
        .map((sub) => sub.id)
        .toList();

    await Future.wait([
      SubAccountBox.removeManyAsync(idsToDelete),
      AccountBox.putAsync(accountEntity),
    ]);
  }


  @override
  Future<void> deleteAccount(Account accountModel) {
    return AccountBox.removeAsync(int.parse(accountModel.id));
  }

  @override
  Future<void> saveAccount(List<AccountModel> accountToCache) {
    return Future(() => AccountBox.putMany(accountToCache
        .map((e) => OutcomeCategoryEntity(
        int.parse(e.id), e.name, e.image, e.position, e.desc))
        .toList()));
  }

  @override
  Future<List<AccountModel>> filterAccount(String params) {
    return Future.value(AccountBox
        .query(
        AccountEntity_.name.contains(params, caseSensitive: false))
        .build()
        .find()
        .map((e) => AccountModel(
        id: e.id.toString(),
        position: e.position!,
        name: e.name!,
        desc: e.desc!,
        image: e.image!))
        .toList());
  }

  @override
  Future<void> generateAccount() async {
    final jsonData =
    json.decode(accountInitializeData) as Map<String, dynamic>;
    final List<dynamic> data = jsonData['data'];

    for (var account in data) {
      final accountEntity = AccountEntity(
          int.parse(account["_id"]),
          account["name"],
          account["image"],
          account["position"],
          account["desc"]);
      AccountBox.put(accountEntity);
    }
  }
}

const String accountInitializeData = '''
{
  "data": [
    {
      "_id": "1",
      "position": 1,
      "name": "Makan Dan Minum",
      "desc": "Bahan Makanan",
      "image": "image1.png"
    },
    {
      "_id": "2",
      "position": 2,
      "name": "Bahan Makanan",
      "desc": "Description for Category 2",
      "image": "image2.png"
    },
    {
      "_id": "3",
      "position": 3,
      "name": "Belanja",
      "desc": "Description for Category 3",
      "image": "image3.png"
    },
    {
      "_id": "4",
      "position": 4,
      "name": "Bensin",
      "desc": "Description for Category 4",
      "image": "image3.png"
    },
    {
      "_id": "5",
      "position": 5,
      "name": "Transportasi",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "6",
      "position": 6,
      "name": "Asuransi",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "7",
      "position": 7,
      "name": "Donasi",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "8",
      "position": 8,
      "name": "Edukasi",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "9",
      "position": 9,
      "name": "Hiburan",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "10",
      "position": 10,
      "name": "Investasi",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "11",
      "position":11,
      "name": "Kecantikan",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "12",
      "position": 12,
      "name": "Keluarga dan Teman",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "13",
      "position": 13,
      "name": "Kesehatan",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "13",
      "position": 13,
      "name": "Liburan",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "14",
      "position": 14,
      "name": "Olahraga",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "15",
      "position": 15,
      "name": "Lainnya",
      "desc": "Description for Category 5",
      "image": "image3.png"
    }
  ]
}
''';
