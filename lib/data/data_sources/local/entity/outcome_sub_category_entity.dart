import 'package:eshop/data/data_sources/local/entity/outcome_category_entity.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:eshop/domain/entities/category/outcome_sub_category.dart';
import 'package:objectbox/objectbox.dart';


@Entity()
class OutcomeSubCategoryEntity {

  @Id(assignable: true)
  int id = 0;

  String? name;

  String? desc;

  final outcomeCategory = ToOne<OutcomeCategoryEntity>();

  OutcomeSubCategoryEntity(this.id, this.name, this.desc);

  factory OutcomeSubCategoryEntity.fromModel(
      OutcomeSubCategory data, OutcomeCategory categoryEntity) {
    final subCategoryEntity = OutcomeSubCategoryEntity(
        int.parse(data.id), data.name, data.desc);
    subCategoryEntity.outcomeCategory.target = OutcomeCategoryEntity.fromModel(categoryEntity); // Set the relation here
    return subCategoryEntity;
  }
}


