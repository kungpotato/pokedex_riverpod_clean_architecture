import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/app/presentation/pages/home/providers/home_notifier.dart';
import 'package:pokedex/app/presentation/pages/home/providers/state/home_state.dart';

void main() {
  test('initial state is correct', () {
    final container = ProviderContainer(
      overrides: [homeNotifierProvider.overrideWith(MockHomeNotifier.new)],
    );

    final notifier = container.read(homeNotifierProvider.notifier);

    notifier.state = const AsyncData(HomeState.initial());

    expect(notifier.state.value, const HomeState());
  });

  test('updatePokemonList updates the state', () {
    final container = ProviderContainer(
      overrides: [homeNotifierProvider.overrideWith(MockHomeNotifier.new)],
    );

    final notifier = container.read(homeNotifierProvider.notifier);
    notifier.state = const AsyncData(HomeState.initial());
    
    final updatedList = [
      const PokemonModel(name: 'Baseurl', url: 'www.google.com'),
    ];

    final newState = notifier.state.value?.copyWith(
      pokemonList: updatedList,
    );
    notifier.state = AsyncData(newState ?? const HomeState.initial());

    expect(
      notifier.state.value?.pokemonList.map((e) => e.toEntity()),
      updatedList.map((e) => e.toEntity()),
    );
  });
}
