part of 'setting_bloc.dart';


@immutable
abstract class SettingEvent extends Equatable{
  const SettingEvent();
}

class CheckSetting extends SettingEvent {
  @override
  List<Object?> get props => [];
}

class SaveSetting extends SettingEvent {
  final SettingModel params;
  SaveSetting(this.params);

  @override
  List<Object?> get props => [];
}

