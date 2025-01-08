import 'package:equatable/equatable.dart';

class AccountGroup extends Equatable {
  final String id;
  final String name;

  const AccountGroup({
    required this.id,
    required this.name,
  });

  AccountGroup copyWith({bool? isUpdated}) {
    return AccountGroup(
      id: id,
      name: name,
    );
  }

  @override
  List<Object?> get props => [id];

  static from(map) {}
}

