import 'package:dartz/dartz.dart';
import 'package:eshop/domain/entities/account/account.dart';
import 'package:eshop/domain/entities/income/income.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../data/models/income/income_model.dart';
import '../../repositories/account_repository.dart';
import '../../repositories/income_repository.dart';


class SaveIncomeUseCase implements UseCase<Income, IncomeModel> {
  final IncomeRepository repository;
  SaveIncomeUseCase(this.repository);

  @override
Future<Either<Failure, Income>> call(IncomeModel params) async {
  return await repository.saveIncome(params);
}
}
