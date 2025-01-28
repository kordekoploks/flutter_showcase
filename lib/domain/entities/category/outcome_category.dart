import 'package:equatable/equatable.dart';

import 'outcome_sub_category.dart';

class OutcomeCategory extends Equatable {
  final String id;
  final int position;
  final String name;
  final String desc;
  final String image;
  final List<OutcomeSubCategory> outcomeSubCategory;
  final bool isUpdated;

  const OutcomeCategory({
    required this.id,
    required this.position,
    required this.name,
    required this.desc,
    required this.image,
    this.outcomeSubCategory = const [],
    this.isUpdated = false,
  });

  OutcomeCategory copyWith({bool? isUpdated}) {
    return OutcomeCategory(
      id: id,
      position: position,
      name: name,
      desc: desc,
      image: image,
      outcomeSubCategory: outcomeSubCategory,
      isUpdated: isUpdated ?? this.isUpdated,
    //   otomatis terudate saat memasukan yang dibutuhkan
    );
  }

  @override
  List<Object?> get props => [id];
}
