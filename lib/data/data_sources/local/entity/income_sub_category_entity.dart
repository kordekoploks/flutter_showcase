
import 'package:objectbox/objectbox.dart';

import '../../../../domain/entities/category/income_category.dart';
import '../../../../domain/entities/category/income_sub_category.dart';
import 'income_category_entity.dart';


@Entity()
class IncomeSubCategoryEntity {

  @Id(assignable: true)
  int id = 0;

  String? name;

  String? desc;

  final incomeCategory = ToOne<IncomeCategoryEntity>();

  IncomeSubCategoryEntity(this.id, this.name, this.desc);

  factory IncomeSubCategoryEntity.fromModel(
      IncomeSubCategory data, IncomeCategory categoryEntity) {
    final subCategoryEntity = IncomeSubCategoryEntity(
        int.parse(data.id), data.name, data.desc);
    subCategoryEntity.incomeCategory.target = IncomeCategoryEntity.fromModel(categoryEntity); // Set the relation here
    return subCategoryEntity;
  }
}


