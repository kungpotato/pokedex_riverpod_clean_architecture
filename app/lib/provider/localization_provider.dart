import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/localization/localize.dart';

part 'localization_provider.g.dart';

@localize
final localizationProvider = Provider<Localization>((ref) {
  final remoteConfig = FirebaseRemoteConfig.instance;
  final all = remoteConfig.getAll();
  final appHome = all['app_home']?.asString() ?? '{}';
  final json = jsonDecode(appHome) as Map<String, dynamic>;

  final localization = Localization.fromRemoteConfig(json);

  return localization;
});
