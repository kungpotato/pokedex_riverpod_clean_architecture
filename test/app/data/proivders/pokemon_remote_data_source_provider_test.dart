import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:pokedex/app/data/data_sources/remote/pokemon_remote_data_source.dart';
import 'package:pokedex/app/data/providers/pokemon_remote_data_source_provider.dart';
import 'package:riverpod/riverpod.dart';

import 'pokemon_remote_data_source_provider_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late Dio mockDio;

  setUp(() {
    mockDio = MockDio();
  });

  test(
      'pokemonRemoteDatasourceProvider should create an instance of PokemonRemoteDataSourceImpl',
      () {
    final container = ProviderContainer(
      overrides: [
        pokemonRemoteDatasourceProvider.overrideWithProvider(
          Provider.family<PokemonRemoteDataSourceImpl, Dio>(
            (_, __) => PokemonRemoteDataSourceImpl(mockDio),
          ),
        ),
      ],
    );

    final pokemonRemoteDataSource =
        container.read(pokemonRemoteDatasourceProvider(mockDio));

    expect(pokemonRemoteDataSource, isA<PokemonRemoteDataSourceImpl>());
  });
}
