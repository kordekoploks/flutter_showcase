import 'dart:ffi';

import 'package:equatable/equatable.dart';


class Account extends Equatable {
  final String id;
  final String name;
  final String desc;
  final Long initialAmt;
  final String accountGroup;
  final bool isUpdated;

  const Account({
    required this.id,
    required this.name,
    required this.desc,
    required this.initialAmt,
    this.accountGroup = GROUP_CASH,
    this.isUpdated = false,
  });

  Account copyWith({bool? isUpdated}) {
    return Account(
      id: id,
      name: name,
      desc: desc,
      initialAmt: initialAmt,
      accountGroup: accountGroup,
      isUpdated: isUpdated ?? this.isUpdated,
    );
  }

  @override
  List<Object?> get props => [id];
}

const String GROUP_CASH = "GROUP_CASH";
