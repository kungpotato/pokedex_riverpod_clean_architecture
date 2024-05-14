import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/app/presentation/home/providers/state/home_state.dart';

void main() {
  group('HomeState', () {
    test('Default constructor sets default values', () {
      const state = HomeState();
      expect(state.pokemonList, <PokemonModel>[]);
    });

    test('Initial named constructor sets default values', () {
      const state = HomeState.initial();
      expect(state.pokemonList, <PokemonModel>[]);
    });

    test('copyWith returns a new instance with updated values', () {
      const initialList = [
        PokemonModel(name: 'Pikachu', url: 'www.google.com'),
        PokemonModel(name: 'Bulbasaur', url: 'www.google.com'),
      ];
      const updatedList = [
        PokemonModel(name: 'Charmander', url: 'www.google.com'),
      ];

      const state = HomeState(pokemonList: initialList);

      final updatedState = state.copyWith(pokemonList: updatedList);

      expect(updatedState.pokemonList, updatedList);
      expect(state.pokemonList, initialList);
    });

    test('copyWith returns the same instance if no changes are made', () {
      const initialList = [
        PokemonModel(name: 'Pikachu', url: 'www.google.com'),
      ];

      const state = HomeState(pokemonList: initialList);

      final updatedState = state.copyWith();

      expect(updatedState.pokemonList, initialList);
      expect(updatedState, state);
    });
  });
}
