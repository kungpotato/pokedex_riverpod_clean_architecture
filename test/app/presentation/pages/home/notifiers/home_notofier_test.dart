import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/app/presentation/home/notifiers/home_notifier.dart';
import 'package:pokedex/app/presentation/home/notifiers/state/home_state.dart';
import 'package:pokedex/core/utils/mapper.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer(
      overrides: [
        homeNotifierProvider.overrideWith(HomeNotifierMock.new),
      ],
    );
  });

  const tLimit = 2;
  final tPokemonList = List<PokemonModel>.generate(
    tLimit,
    (index) => PokemonModel(
      name: 'Pokemon $index',
      url: 'https://pokeapi.co/api/v2/ability/7/',
    ),
  );

  test('initial state should be AsyncLoading', () {
    // Arrange
    final notifier = container.read(homeNotifierProvider.notifier);
    notifier.state = const AsyncLoading<HomeState>();

    // Act
    final state = container.read(homeNotifierProvider);

    // Assert
    expect(state, isA<AsyncLoading<HomeState>>());
  });

  group('fetchPokemon', () {
    test('should fetch pokemon data and update state on success', () async {
      // Arrange
      final notifier = container.read(homeNotifierProvider.notifier);
      notifier.state = AsyncData(HomeState(pokemonList: tPokemonList));

      // Act
      final state = container.read(homeNotifierProvider);

      // Assert
      expect(state.value?.pokemonList, isNotEmpty);
      expect(
        state.value?.pokemonList.toPokemonEntity(),
        tPokemonList.map((e) => e.toEntity()),
      );
    });
  });
}
