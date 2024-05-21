import 'package:core_providers/core_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/src/app/data/data_sources/local/user_local_data_source.dart';

final userLocalDataSourceProvider = Provider<UserLocalDataSource>((ref) {
  return UserLocalDataSourceImpl(
    sharedPreferences: ref.read(sharedPreferencesProvider),
    secureStorage: ref.read(secureStorageProvider),
  );
});
