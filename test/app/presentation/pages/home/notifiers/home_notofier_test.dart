import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/app/domain/entities/pokemon/pokemon.dart';
import 'package:pokedex/app/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/app/domain/use_cases/get_pokemon.dart';
import 'package:pokedex/app/presentation/home/notifiers/home_notifier.dart';
import 'package:pokedex/app/presentation/home/notifiers/state/home_state.dart';
import 'package:pokedex/core/providers/repository/pokemon_repository_provider.dart';

import 'home_notofier_test.mocks.dart';

@GenerateMocks([PokemonRepository])
void main() {
  late GetPokemon getPokemon;
  late PokemonRepository mockPokemonRepository;
  late ProviderContainer container;
  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    getPokemon = GetPokemon(mockPokemonRepository);
    container = ProviderContainer(
      overrides: [
        pokemonRepositoryProvider.overrideWithValue(mockPokemonRepository),
      ],
    );
  });

  const tPokemon =
      Pokemon(name: 'Pikachu', url: 'https://pokeapi.co/api/v2/ability/7/');

  test('initial state should be AsyncLoading', () {
    final notifier = container.read(homeNotifierProvider.notifier);
    expect(notifier.state, isA<AsyncLoading<HomeState>>());
  });

  group('fetchPokemon', () {
    test('should fetch pokemon data and update state on success', () async {
      // Arrange
      const getPokemonParam = GetPokemonParams(limit: 100);
      when(getPokemon(getPokemonParam)).thenAnswer(
        (_) async => const Right([tPokemon]),
      );

      // Act
      final notifier = container.read(homeNotifierProvider.notifier);
      final res = await notifier.fetchPokemon(getPokemon);

      // Assert
      expect(
        res.pokemonList.map((e) => e.toEntity()).toList(),
        [tPokemon],
      );
    });
  });
}
