import 'package:equatable/equatable.dart';

import 'AccountGroup.dart';

class Account extends Equatable {
  final String id;
  final String name;
  final String desc;
  final AccountGroup? accountGroup;
  final bool isUpdated;

  const Account({
    required this.id,
    required this.name,
    required this.desc,
    this.accountGroup = const AccountGroup(id: "1", name: "Cash"),
    this.isUpdated = false,
  });

  Account copyWith({bool? isUpdated}) {
    return Account(
      id: id,
      name: name,
      desc: desc,
      accountGroup: accountGroup,
      isUpdated: isUpdated ?? this.isUpdated,
    );
  }

  @override
  List<Object?> get props => [id];
}
