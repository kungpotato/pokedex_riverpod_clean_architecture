import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/data/data_sources/local/user_local_data_source.dart';
import 'package:pokedex/core/providers/storage_provider.dart';

final userLocalDataSourceProvider = Provider<UserLocalDataSource>((ref) {
  return UserLocalDataSourceImpl(
    sharedPreferences: ref.read(sharedPreferencesProvider),
    secureStorage: ref.read(secureStorageProvider),
  );
});
