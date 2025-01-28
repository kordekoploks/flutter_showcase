import 'dart:convert';

import 'package:eshop/data/models/income/income_model.dart';
import 'package:eshop/domain/entities/account/account.dart';

import '../../../domain/entities/income/income.dart';
import '../../../objectbox.g.dart';
import '../../models/account/account_model.dart';
import 'entity/account_entity.dart';
import 'entity/income_entity.dart';

abstract class IncomeLocalDataSource {
  Future<List<Income>> getIncomes();

  Future<void> saveIncome(IncomeModel incomeModel);

  Future<void> deleteIncome(Income incomeModel);

  Future<void> generateIncome();
}

const cachedIncome = 'CACHED_INCOME';

class IncomeLocalDataSourceImpl implements IncomeLocalDataSource {
  final Box<IncomeEntity> incomeBox;
  final Store store;

  IncomeLocalDataSourceImpl({required this.incomeBox, required this.store});

  @override
  Future<List<IncomeModel>> getIncomes() {
    return Future.value(
        incomeBox.getAll().map((e) => IncomeModel.fromEntity(e)).toList());
  }

  @override
  Future<void> saveIncome(IncomeModel e) async {
    final incomeEntity = IncomeEntity.fromModel(e as Income);

    await Future.wait([
      incomeBox.putAsync(incomeEntity),
    ]);
  }

  @override
  Future<void> deleteIncome(Income incomeModel) {
    return incomeBox.removeAsync(int.parse(incomeModel.id));
  }

  @override
  Future<void> saveIncomes(List<IncomeModel> incomeToCache) {
    return Future(() => incomeBox.putMany(incomeToCache
        .map((income) => IncomeEntity(int.parse(income.idAccount), income.date,
        income.amount, income.category, income.note, income.isRepeat))
        .toList()));
  }

}

