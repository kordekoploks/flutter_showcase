import 'package:equatable/equatable.dart';

class IncomeSubCategory extends Equatable {
  final String id;
  final String name;
  final String desc;
  final bool isUpdated;
  const IncomeSubCategory({
    required this.id,
    required this.name,
    required this.desc,
    this.isUpdated = false,
  });

  IncomeSubCategory copyWith({bool? isUpdated}) {
    return IncomeSubCategory(
      id: id,
      name: name,
      desc:  desc,
      isUpdated: isUpdated ?? this.isUpdated,
    );
  }
  @override
  List<Object?> get props => [id];
}
