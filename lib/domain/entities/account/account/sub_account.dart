import 'package:equatable/equatable.dart';

class SubAccount extends Equatable {
  final String id;
  final String name;
  final String desc;
  final bool isUpdated;
  const SubAccount({
    required this.id,
    required this.name,
    required this.desc,
    this.isUpdated = false,
  });

  SubAccount copyWith({bool? isUpdated}) {
    return SubAccount(
      id: id,
      name: name,
      desc:  desc,
      isUpdated: isUpdated ?? this.isUpdated,
    );
  }
  @override
  List<Object?> get props => [id];
}
