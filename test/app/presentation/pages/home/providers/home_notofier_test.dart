import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/app/presentation/home/notifiers/home_notifier.dart';
import 'package:pokedex/app/presentation/home/notifiers/state/home_state.dart';

void main() {
  test('initial state is correct', () {
    final container = ProviderContainer(
      overrides: [homeNotifierProvider.overrideWith(MockHomeNotifier.new)],
    );

    final notifier = container.read(homeNotifierProvider.notifier);

    notifier.state = const HomeState.initial();

    expect(notifier.state, const HomeState());
  });

  test('updatePokemonList updates the state', () {
    final container = ProviderContainer(
      overrides: [homeNotifierProvider.overrideWith(MockHomeNotifier.new)],
    );

    final notifier = container.read(homeNotifierProvider.notifier);
    notifier.state = const HomeState.initial();

    final updatedList = [
      const PokemonModel(name: 'Baseurl', url: 'www.google.com'),
    ];

    final newState = notifier.state.copyWith(
      pokemonList: updatedList,
    );
    notifier.state = newState;

    expect(
      notifier.state.pokemonList.map((e) => e.toEntity()),
      updatedList.map((e) => e.toEntity()),
    );
  });
}
