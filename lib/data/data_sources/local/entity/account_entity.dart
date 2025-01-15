
import 'dart:ffi';

import 'package:eshop/domain/entities/account/account.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class AccountEntity {
  @Id(assignable: true)
  int id = 0;

  String? name;

  double? initialAmt;

  String? desc;

  String accountGroup;


  AccountEntity(
      this.id, this.name, this.initialAmt, this.desc, this.accountGroup);

  factory AccountEntity.fromModel(Account data) {
    return AccountEntity(
        int.parse(data.id), data.name, data.initialAmt, data.desc, data.accountGroup);
  }
}
