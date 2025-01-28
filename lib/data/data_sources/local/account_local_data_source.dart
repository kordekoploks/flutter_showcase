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
}

const cachedAccount = 'CACHED_ACCOUNT';

class AccountLocalDataSourceImpl implements AccountLocalDataSource {
  final Box<AccountEntity> accountBox;
  final Store store;

  AccountLocalDataSourceImpl({required this.accountBox, required this.store});

  @override
  Future<List<AccountModel>> getAccounts() {
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
      final accountEntity = AccountEntity(
          int.parse(account["_id"]),
          account["name"],
          account["position"],
          account["desc"],
          account["accountGroup"]);
      accountBox.put(accountEntity);
    }
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
      "name": "Loan",
      "initialAmt": "0",
      "desc": "Loan Desc",
      "accountGroup": "LOAN_CASH"
    },      ]
}
''';
