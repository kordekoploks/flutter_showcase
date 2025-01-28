
import 'dart:ffi';

import 'package:eshop/domain/entities/account/account.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class IncomeEntity {
  @Id(assignable: true)
  int idAccount = 0;

  String date;

  double amount;

  String category;

  String note;

  String isRepeat;




  IncomeEntity(
      this.idAccount, this.date, this.amount, this.category, this.note, this.isRepeat);

  factory IncomeEntity.fromModel(Income data) {
    return IncomeEntity(
        int.parse(data.idAccount), data.date, data.amount, data.category, data.note, data.isRepeat);
  }
}
