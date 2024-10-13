import 'package:equatable/equatable.dart';

class OutcomeSubCategory extends Equatable {
  final String id;
  final String name;
  final String desc;
  final bool isUpdated;
  const OutcomeSubCategory({
    required this.id,
    required this.name,
    required this.desc,
    this.isUpdated = false,
  });

  OutcomeSubCategory copyWith({bool? isUpdated}) {
    return OutcomeSubCategory(
      id: id,
      name: name,
      desc:  desc,
      isUpdated: isUpdated ?? this.isUpdated,
    );
  }
  @override
  List<Object?> get props => [id];
}
