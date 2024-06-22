import 'package:dartz/dartz.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/data/models/setting/setting_model.dart';
import 'package:eshop/domain/entities/setting/setting.dart';
import 'package:eshop/domain/repositories/setting_repository.dart';

import '../data_sources/local/user_local_data_source.dart';

class SettingRepositoryImpl implements SettingRepository{

  final UserLocalDataSource localDataSource;


  SettingRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, Setting>> getCachedSetting() async {
    try {
      final setting = await localDataSource.getSetting();
      return Right(setting);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Setting>> updateSetting(SettingModel params) async {
    try {
      localDataSource.saveSetting(params);
      return Right(params);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

}