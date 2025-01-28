import 'package:dartz/dartz.dart';
import 'package:eshop/domain/entities/account/account.dart';

import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';
import '../../../data/data_sources/local/account_local_data_source.dart';
import '../../../data/models/account/account_model.dart';
import '../../domain/entities/income/income.dart';
import '../../domain/repositories/income_repository.dart';
import '../data_sources/local/income_local_data_source.dart';
import '../data_sources/remote/account_remote_data_source.dart';
import '../../domain/repositories/account_repository.dart';
import '../models/income/income_model.dart';

class IncomeRepositoryImpl implements IncomeRepository {
  final IncomeLocalDataSource localDataSource;

  IncomeRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Income>> saveIncome(IncomeModel params) async {
    try {
      await localDataSource.saveIncome(params);
      return Right(params);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
