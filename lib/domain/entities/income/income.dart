import 'dart:ffi';

import 'package:equatable/equatable.dart';


class Income extends Equatable {
  final String idAccount;
  final String idIncome;
  final String date;
  final Double amount;
  final String category;
  final String note;
  final Bool isRepeat;
  final bool isUpdated;

  const Income({

    required this.idAccount,
    required this.idIncome,
    required this.date,
    required this.amount,
    required this.category,
    required this.note,
    required this.isRepeat,
    this.isUpdated = false,
  });

  Income copyWith({bool? isUpdated}) {
    return Income(
      idAccount: idAccount,
      idIncome: idIncome,
      date: date,
      amount: amount,
      category: category,
      note: note,
      isRepeat: isRepeat,
      isUpdated: isUpdated ?? this.isUpdated,
    );
  }

  @override
  List<Object?> get props => [idAccount];

}
