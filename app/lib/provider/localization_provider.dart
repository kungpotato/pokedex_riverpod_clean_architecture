import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/localization/localize.dart';

part 'localization_provider.g.dart';

@localize
final localizationProvider = FutureProvider<Localization>((ref) async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.fetchAndActivate();

  final localization = Localization.fromRemoteConfig(
    remoteConfig.getAll().map((key, value) => MapEntry(key, value.asString())),
  );

  return localization;
});
