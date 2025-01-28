import 'dart:ffi';

import 'package:eshop/data/data_sources/local/entity/outcome_sub_category_entity.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class OutcomeCategoryEntity {
  @Id(assignable: true)
  int id = 0;

  String? name;

  String? image;

  int? position;

  String? desc;

  @Backlink('outcomeCategory')
  final subCategories = ToMany<OutcomeSubCategoryEntity>();

  OutcomeCategoryEntity(
      this.id, this.name, this.image, this.position, this.desc);

  factory OutcomeCategoryEntity.fromModel(OutcomeCategory data) {
    return OutcomeCategoryEntity(
        int.parse(data.id), data.name, data.image, data.position, data.desc);
  }
}
