import 'package:dartz/dartz.dart';
import 'package:eshop/data/models/category/outcome_category_model.dart';
import 'package:eshop/domain/entities/account/account.dart';

import '../../../core/error/failures.dart';
import '../../../data/models/account/account_model.dart';
import '../../data/models/income/income_model.dart';
import '../entities/income/income.dart';

abstract class IncomeRepository {


  Future<Either<Failure, Income>> saveIncome(
      IncomeModel keyword);

}
