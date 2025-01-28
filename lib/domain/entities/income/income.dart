import 'dart:ffi';

import 'package:equatable/equatable.dart';


class Income extends Equatable {
  final String id;
  final String idAccount;
  final String date;
  final double amount;
  final String category;
  final String note;
  final bool isRepeat;
  final bool isUpdated;

  const Income({
    required this.id,
    required this.idAccount,
    required this.date,
    required this.amount,
    required this.category,
    required this.note,
    this.isRepeat= false,
    this.isUpdated = false,
  });

  Income copyWith({bool? isUpdated}) {
    return Income(
      id: id,
      idAccount: idAccount,
      date: date,
      amount: amount,
      category: category,
      note: note,
      isRepeat: isRepeat,
      isUpdated: isUpdated ?? this.isUpdated,
    );
  }

  @override
  List<Object?> get props => [id];

}
