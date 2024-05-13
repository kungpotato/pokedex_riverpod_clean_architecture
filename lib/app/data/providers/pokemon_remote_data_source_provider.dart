import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/data/data_sources/remote/pokemon_remote_data_source.dart';

final pokemonRemoteDatasourceProvider =
    Provider.family<PokemonRemoteDataSourceImpl, Dio>(
  (_, networkService) => PokemonRemoteDataSourceImpl(networkService),
);
