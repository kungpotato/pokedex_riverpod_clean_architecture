import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/data/data_sources/local/user_local_data_source.dart';
import 'package:pokedex/app/data/data_sources/remote/pokemon_remote_data_source.dart';
import 'package:pokedex/app/data/imp_repositories/pokemon_repo_imp.dart';
import 'package:pokedex/app/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/core/providers/dio_provider.dart';
import 'package:pokedex/core/providers/network_provider.dart';
import 'package:pokedex/core/providers/storage_provider.dart';

final userLocalDataSourceProvider = Provider<UserLocalDataSource>((ref) {
  return UserLocalDataSourceImpl(
    sharedPreferences: ref.watch(sharedPreferencesProvider),
    secureStorage: ref.watch(secureStorageProvider),
  );
});

final pokemonDatasourceProvider =
    Provider.family<PokemonRemoteDataSourceImpl, Dio>(
  (_, networkService) => PokemonRemoteDataSourceImpl(networkService),
);

final Provider<PokemonRepository> pokemonRepositoryProvider =
    Provider<PokemonRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final remoteDataSource = ref.watch(pokemonDatasourceProvider(dio));
  final repository = PokemonRepoImp(
    remoteDataSource: remoteDataSource,
    networkInfo: ref.watch(networkInfoProvider),
    userLocalDataSource: ref.watch(userLocalDataSourceProvider),
  );

  return repository;
});
