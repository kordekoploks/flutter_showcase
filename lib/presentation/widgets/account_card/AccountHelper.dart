import 'package:eshop/data/models/account/account_model.dart';

class AccountDefaults {
  static const AccountModel defaultAccount = AccountModel(
    id: "1",
    name: "Cash",
    desc: "Cash Desc",
    initialAmt: 0,
    accountGroup: "CASH_GROUP",
  );
}