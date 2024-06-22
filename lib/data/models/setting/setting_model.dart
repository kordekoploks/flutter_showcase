import 'dart:convert';

import '../../../domain/entities/setting/setting.dart';

SettingModel settingModelFromJson(String str) => SettingModel.fromJson(json.decode(str));

String settingModelToJson(SettingModel data) => json.encode(data.toJson());

class SettingModel extends Setting {
  const SettingModel({
    required bool darkMode,
  }) : super(
    darkMode: darkMode,
  );

  factory SettingModel.fromJson(Map<String, dynamic> json) =>  SettingModel(
    darkMode:  json["darkMode"] as bool,
  );

  Map<String, dynamic> toJson() => {
    "darkMode": darkMode
  };
}
