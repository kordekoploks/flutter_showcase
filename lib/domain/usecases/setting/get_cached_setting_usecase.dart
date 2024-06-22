import 'package:dartz/dartz.dart';
import 'package:eshop/domain/repositories/setting_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/setting/setting.dart';

class GetCachedSettingUseCase implements UseCase<Setting, NoParams> {
  final SettingRepository repository;
  GetCachedSettingUseCase(this.repository);

  @override
  Future<Either<Failure, Setting>> call(NoParams params) async {
    return await repository.getCachedSetting();
  }
}
