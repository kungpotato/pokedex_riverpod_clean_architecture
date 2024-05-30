import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  RemoteConfigService(this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;

  Future<void> fetchAndActivate() async {
    try {
      await _remoteConfig.fetch();
      await _remoteConfig.activate();
    } catch (e) {
      throw Exception(
        'Failed to fetch and activate remote config: $e',
      );
    }
  }

  String getString(String key) {
    return _remoteConfig.getString(key);
  }

  bool getBool(String key) {
    return _remoteConfig.getBool(key);
  }

  int getInt(String key) {
    return _remoteConfig.getInt(key);
  }

  double getDouble(String key) {
    return _remoteConfig.getDouble(key);
  }

  Map<String, dynamic> getJson() {
    final jsonString = _remoteConfig.getAll();

    try {
      return jsonString;
    } catch (e) {
      throw Exception('Failed to parse JSON : $e');
    }
  }
}
