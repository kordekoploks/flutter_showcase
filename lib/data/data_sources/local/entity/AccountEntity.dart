
import 'dart:ffi';

import 'package:eshop/domain/entities/account/Account.dart';
import 'package:eshop/domain/entities/account/AccountGroup.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class AccountEntity {
  @Id(assignable: true)
  int id = 0;

  String? name;

  Long? initialAmt;

  String? desc;

  final accountGroup = ToOne<AccountGroup>();

  AccountEntity(
      this.id, this.name, this.initialAmt, this.desc);

  factory AccountEntity.fromModel(Account data) {
    return AccountEntity(
        int.parse(data.id), data.name, data.initialAmt, data.desc);
  }
}
