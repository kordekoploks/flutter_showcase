import 'dart:convert';

import '../../../domain/entities/income/income.dart';
import '../../data_sources/local/entity/income_entity.dart';



List<IncomeModel> incomeModelListFromRemoteJson(String str) =>
    List<IncomeModel>.from(
        json.decode(str)['data'].map((x) => IncomeModel.fromJson(x)));

List<IncomeModel> incomeModelListFromLocalJson(String str) =>
    List<IncomeModel>.from(
        json.decode(str).map((x) => IncomeModel.fromJson(x)));

String incomeModelListToJson(List<IncomeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IncomeModel extends Income {
  const IncomeModel(
      { required super.id,
        required super.idAccount,
        required super.date,
        required super.amount,
        required super.category,
        required super.note,
        required super.isRepeat});

  factory IncomeModel.fromJson(Map<String, dynamic> json) => IncomeModel(
      id: json["_id"],
      idAccount: json["_idAccount"],
      date: json["date"],
      amount: json["amount"],
      category: json["category"],
      note: json["note"],
      isRepeat: json["_isRepeat"],);

  Map<String, dynamic> toJson() => {
    "_id": id,
    "_idAccount": idAccount,
    "date": date,
    "amount": amount,
    "category": category,
    "note": note,
    "isRepeat": isRepeat,
  };

  factory IncomeModel.fromInterface(Income entity) => IncomeModel(
    id: entity.id,
    idAccount: entity.idAccount,
    date: entity.date,
    amount: entity.amount,
    category: entity.category,
    note: entity.note,
    isRepeat: entity.isRepeat,
  );

  factory IncomeModel.fromEntity(IncomeEntity entity) => IncomeModel(
      id: entity.id.toString(),
      idAccount: entity.idAccount,
      date: entity.date,
      amount: entity.amount,
      category: entity.category,
      note: entity.note,
      isRepeat: entity.isRepeat);
}
