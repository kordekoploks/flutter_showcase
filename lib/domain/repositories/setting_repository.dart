import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/setting/setting_model.dart';
import '../entities/setting/setting.dart';

abstract class SettingRepository {
  Future<Either<Failure, Setting>> getCachedSetting();
  Future<Either<Failure, Setting>> updateSetting(SettingModel params);
}
