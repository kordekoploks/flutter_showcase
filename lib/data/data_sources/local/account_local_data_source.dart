import 'dart:convert';

import 'package:eshop/domain/entities/account/account.dart';

import '../../../objectbox.g.dart';
import '../../models/account/account_model.dart';
import 'entity/account_entity.dart';

abstract class AccountLocalDataSource {
  Future<List<Account>> getAccounts();

  Future<void> saveAccount(AccountModel accountModel);

  Future<void> deleteAccount(Account accountModel);

  Future<void> generateAccount();

  Future<List<Account>> filterAccounts(String params);
}

const cachedAccount = 'CACHED_ACCOUNT';

class AccountLocalDataSourceImpl implements AccountLocalDataSource {
  final Box<AccountEntity> accountBox;
  final Store store;

  AccountLocalDataSourceImpl({required this.accountBox, required this.store});

  @override
  Future<List<AccountModel>> getAccounts() async {
    await generateAccount();
    return Future.value(
        accountBox.getAll().map((e) => AccountModel.fromEntity(e)).toList());
  }

  @override
  Future<void> saveAccount(AccountModel e) async {
    final accountEntity = AccountEntity.fromModel(e as Account);

    await Future.wait([
      accountBox.putAsync(accountEntity),
    ]);
  }

  @override
  Future<void> deleteAccount(Account accountModel) {
    return accountBox.removeAsync(int.parse(accountModel.id));
  }

  @override
  Future<void> saveAccounts(List<AccountModel> accountToCache) {
    return Future(() => accountBox.putMany(accountToCache
        .map((account) => AccountEntity(int.parse(account.id), account.name,
            account.initialAmt, account.desc, account.accountGroup))
        .toList()));
  }

  @override
  Future<void> generateAccount() async {
    final jsonData = json.decode(accountInitializeData) as Map<String, dynamic>;
    final List<dynamic> data = jsonData['data'];

    for (var account in data) {
      final int accountId = int.parse(account["_id"]);

      // Convert initialAmt to double safely
      final double initialAmt =
          double.tryParse(account["initialAmt"].toString()) ?? 0.0;

      // Check if the account already exists in the box
      if (accountBox.get(accountId) == null) {
        final accountEntity = AccountEntity(
          accountId,
          account["name"],
          initialAmt,
          account["desc"],
          account["accountGroup"],
        );
        await accountBox.putAsync(accountEntity);
      }
    }
  }

  @override
  Future<List<Account>> filterAccounts(String params) async {
    return Future.value(accountBox
        .query(AccountEntity_.name.contains(params, caseSensitive: false))
        .build()
        .find()
        .map((e) => AccountModel.fromEntity(e))
        .toList());
  }
}

const String accountInitializeData = '''
{
  "data": [
    {
      "_id": "1",
      "name": "Cash",
      "initialAmt": "0",
      "desc": "Cash Desc",
      "accountGroup": "GROUP_CASH"
    },
   {
      "_id": "2",
      "name": "Main Account",
      "initialAmt": "0",
      "desc": "Loan Desc",
      "accountGroup": "GROUP_ACCOUNT"
  }
  ]
}
''';
