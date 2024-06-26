import 'package:core_providers/core_providers.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home/src/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<String> getToken();

  Future<UserModel> getUser();

  Future<void> saveToken(String token);

  Future<void> saveUser(UserModel user);

  Future<void> clearCache();

  Future<bool> isTokenAvailable();
}

const cachedToken = 'TOKEN';
const cachedUser = 'USER';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl({
    required this.sharedPreferences,
    required this.secureStorage,
  });

  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  @override
  Future<String> getToken() async {
    // final String? token = await secureStorage.read(key: cachedToken);
    // if (token != null) {
    //   return Future.value(token);
    // } else {
    //   throw CacheException();
    // }
    return 'xxx';
  }

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: cachedToken, value: token);
  }

  @override
  Future<UserModel> getUser() async {
    if (sharedPreferences.getBool('first_run') ?? true) {
      await secureStorage.deleteAll();
      await sharedPreferences.setBool('first_run', false);
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
    // final String? token = await secureStorage.read(key: cachedToken);
    // return Future.value(token != null);
    return true;
  }

  @override
  Future<void> clearCache() async {
    await secureStorage.deleteAll();
    await sharedPreferences.remove(cachedUser);
  }
}
