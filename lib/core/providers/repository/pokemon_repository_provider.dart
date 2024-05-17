import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/data/imp_repositories/pokemon_repo_imp.dart';
import 'package:pokedex/app/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/core/providers/data_source/pokemon_remote_data_source_provider.dart';
import 'package:pokedex/core/providers/data_source/user_local_data_source_provider.dart';
import 'package:pokedex/core/providers/dio_provider.dart';
import 'package:pokedex/core/providers/network_provider.dart';

final Provider<PokemonRepository> pokemonRepositoryProvider =
    Provider<PokemonRepository>((ref) {
  final dio = ref.read(dioProvider);
  final remoteDataSource = ref.read(pokemonRemoteDatasourceProvider(dio));
  final repository = PokemonRepoImp(
    remoteDataSource: remoteDataSource,
    networkInfo: ref.read(networkInfoProvider),
    userLocalDataSource: ref.read(userLocalDataSourceProvider),
  );

  return repository;
});
