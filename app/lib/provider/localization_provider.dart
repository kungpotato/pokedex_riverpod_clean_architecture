import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/localization/localize.dart';

part 'localization_provider.g.dart';

@Localize(name: 'Home', path: 'lib/localization/localization_config.json')
final localizationProvider = Provider((ref) {
  final remoteConfig = FirebaseRemoteConfig.instance;
  final all = remoteConfig.getAll();
  final appHome = all['app_home']?.asString() ?? '{}';
  final json = jsonDecode(appHome) as Map<String, dynamic>;

  final localization = HomeLocalization.fromRemoteConfig(json);

  return localization;
});
