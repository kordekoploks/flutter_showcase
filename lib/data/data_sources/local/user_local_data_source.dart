import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exceptions.dart';
import '../../../domain/entities/setting/setting.dart';
import '../../models/setting/setting_model.dart';
import '../../models/user/user_model.dart';
import 'cart_local_data_source.dart';

abstract class UserLocalDataSource {
  Future<String> getToken();

  Future<UserModel> getUser();

  Future<SettingModel> getSetting();

  Future<void> saveToken(String token);

  Future<void> saveUser(UserModel user);

  Future<void> saveSetting(SettingModel settingModel);

  Future<void> clearCache();

  Future<bool> isTokenAvailable();

}

const cachedToken = 'TOKEN';
const cachedUser = 'USER';
const cachedSetting = 'SETTING';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;
  UserLocalDataSourceImpl(
      {required this.sharedPreferences, required this.secureStorage});

  @override
  Future<String> getToken() async {
    String? token = await secureStorage.read(key: cachedToken);
    if (token != null) {
      return Future.value(token);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: cachedToken, value: token);
  }

  @override
  Future<UserModel> getUser() async {
    if (sharedPreferences.getBool('first_run') ?? true) {
      await secureStorage.deleteAll();
      sharedPreferences.setBool('first_run', false);
    }
    final jsonString = sharedPreferences.getString(cachedUser);
    if (jsonString != null) {
      return Future.value(userModelFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveUser(UserModel user) {
    return sharedPreferences.setString(
      cachedUser,
      userModelToJson(user),
    );
  }

  @override
  Future<bool> isTokenAvailable() async {
    String? token = await secureStorage.read(key: cachedToken);
    return Future.value((token != null));
  }

  @override
  Future<void> clearCache() async {
    await secureStorage.deleteAll();
    await sharedPreferences.remove(cachedCart);
    await sharedPreferences.remove(cachedUser);
    await sharedPreferences.remove(cachedSetting);
  }

  @override
  Future<SettingModel> getSetting() async{
    final jsonString = sharedPreferences.getString(cachedSetting);
    if (jsonString != null) {
      return Future.value(settingModelFromJson(jsonString));
    } else {
      return Future.value(const SettingModel(darkMode: false));
    }
  }

  @override
  Future<void> saveSetting(SettingModel settingModel) {
    return sharedPreferences.setString(
      cachedSetting,
      settingModelToJson(settingModel),
    );
  }

}
