import 'dart:convert';

import 'package:eshop/core/error/failures.dart';
import 'package:eshop/data/data_sources/local/entity/outcome_category_entity.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../objectbox.g.dart';
import '../../models/category/outcome_category_model.dart';
import 'entity/outcome_category_entity.dart';
import 'entity/outcome_sub_category_entity.dart';

abstract class AccountLocalDataSource {
}

const cachedCategories = 'CACHED_ACCOUNT';

