
import 'dart:ffi';

import 'package:eshop/domain/entities/account/account.dart';
import 'package:objectbox/objectbox.dart';

import '../../../../domain/entities/income/income.dart';

@Entity()
class IncomeEntity {
  @Id(assignable: true)
  int id = 0;

  String idAccount;

  String date;

  double amount;

  String category;

  String note;

  bool isRepeat;




  IncomeEntity(
  this.id, this.idAccount, this.date, this.amount, this.category, this.note, this.isRepeat);

  factory IncomeEntity.fromModel(Income data) {
    return IncomeEntity(
        int.parse(data.id), data.idAccount,  data.date, data.amount, data.category, data.note, data.isRepeat);
  }
}
