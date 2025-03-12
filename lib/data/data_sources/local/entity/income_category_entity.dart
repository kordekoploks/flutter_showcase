import 'dart:ffi';

import 'package:eshop/data/data_sources/local/entity/outcome_sub_category_entity.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:objectbox/objectbox.dart';

import '../../../../domain/entities/category/income_category.dart';
import 'income_sub_category_entity.dart';

@Entity()
class IncomeCategoryEntity {
  @Id(assignable: true)
  int id = 0;

  String? name;

  String? image;

  int? position;

  String? desc;

  String? icon;


  @Backlink('incomeCategory')
  final subCategories = ToMany<IncomeSubCategoryEntity>();

  IncomeCategoryEntity(
      this.id, this.name, this.image, this.position, this.desc, this.icon);

  factory IncomeCategoryEntity.fromModel(IncomeCategory data) {
    return IncomeCategoryEntity(
        int.parse(data.id), data.name, data.image, data.position, data.desc, data.icon);
  }
}
