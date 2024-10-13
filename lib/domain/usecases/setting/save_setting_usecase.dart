import 'package:dartz/dartz.dart';
import 'package:eshop/data/models/setting/setting_model.dart';
import 'package:eshop/domain/repositories/setting_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/setting/setting.dart';

class SaveSettingUseCase implements UseCase<Setting, SettingModel> {
  final SettingRepository repository;
  SaveSettingUseCase(this.repository);

  @override
  Future<Either<Failure, Setting>> call(SettingModel params) async {
    return await repository.updateSetting(params);
  }
}

