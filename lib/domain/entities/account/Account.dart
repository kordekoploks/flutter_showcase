import 'dart:ffi';

import 'package:equatable/equatable.dart';

import 'AccountGroup.dart';

class Account extends Equatable {
  final String id;
  final String name;
  final String desc;
  final Long initialAmt;
  final AccountGroup? accountGroup;
  final bool isUpdated;

  const Account({
    required this.id,
    required this.name,
    required this.desc,
    required this.initialAmt,
    this.accountGroup = const AccountGroup(id: "0", name: "Cash"),
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
