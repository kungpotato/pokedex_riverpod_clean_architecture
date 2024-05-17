import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/app/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/app/domain/entities/pokemon/pokemon.dart';
import 'package:pokedex/app/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/app/domain/use_cases/get_pokemon.dart';
import 'package:pokedex/app/presentation/home/notifiers/home_notifier.dart';
import 'package:pokedex/app/presentation/home/notifiers/state/home_state.dart';
import 'package:pokedex/core/providers/repository/pokemon_repository_provider.dart';

import 'home_notofier_test.mocks.dart';

@GenerateMocks([GetPokemonParams, PokemonRepository])
void main() {
  late GetPokemon getPokemon;
  late GetPokemonParams mockGetPokemonParams;
  late PokemonRepository mockPokemonRepository;
  late ProviderContainer container;
  setUp(() {
    mockGetPokemonParams = MockGetPokemonParams();
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
  final tPokemonModel = PokemonModel.fromEntity(tPokemon);

  test('initial state should be HomeState.initial()', () {
    final notifier = container.read(homeNotifierProvider.notifier);
    expect(notifier.state, const AsyncData(HomeState.initial()));
  });

  group('fetchPokemon', () {
    test('should fetch pokemon data and update state on success', () async {
      // Arrange
      when(mockPokemonRepository.fetchPokemon(mockGetPokemonParams)).thenAnswer(
        (_) async => const Right([tPokemon]),
      );

      // Act
      final notifier = container.read(homeNotifierProvider.notifier);
      await notifier.fetchPokemon(mockGetPokemonParams);

      // Assert
      expect(notifier.state.value?.pokemonList, [tPokemonModel.toEntity()]);
      verify(getPokemon(mockGetPokemonParams)).called(1);
    });

    // test('should throw an exception and update state on failure', () async {
    //   // Arrange
    //   when(mockGetPokemon(mockGetPokemonParams)).thenAnswer(
    //     (_) async => const Left(ServerFailure(message: 'Server Failure')),
    //   );
    //
    //   // Act
    //   final notifier = container.read(homeNotifierProvider.notifier);
    //   expect(
    //     () => notifier.fetchPokemon(mockGetPokemon),
    //     const ServerFailure(message: 'Server Failure'),
    //   );
    //
    //   // Assert
    //   verify(mockGetPokemon(mockGetPokemonParams)).called(1);
    // });
  });
}
