part of 'setting_bloc.dart';


@immutable
abstract class SettingState extends Equatable {}


class SettingInitial extends SettingState{
  @override
  List<Object> get props => [];
}
class SettingApplied extends SettingState {
  final Setting setting;
  SettingApplied(this.setting);
  @override
  List<Object> get props => [setting];
}

class SettingUpdate extends SettingState {
  final SettingModel setting;
  SettingUpdate(this.setting);
  @override
  List<Object> get props => [setting];
}

class SettingAplliedFail extends SettingState {
  final Failure failure;
  SettingAplliedFail(this.failure);
  @override
  List<Object> get props => [failure];
}


class SettingLoading extends SettingState {
  @override
  List<Object> get props => [];
}

