import 'dart:ffi';

import 'package:eshop/data/data_sources/local/entity/outcome_sub_category_entity.dart';
import 'package:eshop/data/models/category/outcome_category_model.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class AccountEntitiy {
  @Id(assignable: true)
  int id = 0;

  String? name;

  String? initialAmt;

  String? desc;

}
