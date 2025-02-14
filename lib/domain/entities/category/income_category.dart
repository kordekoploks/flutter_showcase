import 'package:equatable/equatable.dart';

import 'income_sub_category.dart';



class IncomeCategory extends Equatable {
  final String id;
  final int position;
  final String name;
  final String desc;
  final String image;
  final List<IncomeSubCategory> incomeSubCategory;
  final bool isUpdated;

  const IncomeCategory({
    required this.id,
    required this.position,
    required this.name,
    required this.desc,
    required this.image,
    this.incomeSubCategory = const [],
    this.isUpdated = false,
  });

  IncomeCategory copyWith({bool? isUpdated}) {
    return IncomeCategory(
      id: id,
      position: position,
      name: name,
      desc: desc,
      image: image,
      incomeSubCategory: incomeSubCategory,
      isUpdated: isUpdated ?? this.isUpdated,
      //   otomatis terudate saat memasukan yang dibutuhkan
    );
  }

  @override
  List<Object?> get props => [id];
}
