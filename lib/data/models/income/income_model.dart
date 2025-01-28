import 'dart:convert';
import 'dart:ffi';

import '../../../domain/entities/income/income.dart';
import '../../data_sources/local/entity/income_entity.dart';



List<IncomeModel> incomeModelListFromRemoteJson(String str) =>
    List<)IncomeModel>.from(
        json.decode(str)['data'].map((x) => IncomeModel.fromJson(x)));

List<IncometModel> incomeModelListFromLocalJson(String str) =>
    List<IncomeModel>.from(
        json.decode(str).map((x) => IncomeModel.fromJson(x)));

String incomeModelListToJson(List<IncomeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IncomeModel extends Income {
  const IncomeModel(
      {required String idAccount,
      required String idIncome,
        required String date,
        required Double amount,
        required String category,
        required String note,
        required Bool isRepeat})
      : super(
      idAccount: idAccount,
      idIncome: idIncome,
      date: date,
      amount: amount,
      category: category,
      note: note,
      isRepeat: isRepeat,);

  factory IncomeModel.fromJson(Map<String, dynamic> json) => IncomeModel(
      idAccount: json["_idAccount"],
      idIncome: json["_idIncome"],
      date: json["date"],
      amount: json["amount"],
      category: json["category"],
      note: json["note"],
      isRepeat: json["isRepeat"]);

  Map<String, dynamic> toJson() => {
    "_idAccount": idAccount,
    "_idIncome": idIncome,
    "date": date,
    "amount": amount,
    "category": category,
    "note": note,
    "isRepeat": isRepeat,
  };

  factory IncomeModel.fromInterface(Income entity) => IncomeModel(
    idAccount: entity.idAccount,
    idIncome: entity.idIncome,
    date: entity.date,
    amount: entity.amount,
    category: entity.category,
    note: entity.note,
    isRepeat: entity.isRepeat,
  );

  factory IncomeModel.fromEntity(IncomeEntity entity) => IncomeModel(
      idAccount: entity.idAccount.toString(),
      idIncome: entity.id.toString(),
      amount: entity.amount,
      category: entity.category,
      note: entity.note,
      isRepeat: entity.isRepeat);
}
