import 'package:flutter_test/flutter_test.dart';
import 'package:home/src/app/data/models/pokemon/pokemon_model.dart';
import 'package:home/src/app/domain/entities/pokemon/pokemon.dart';
import 'package:home/src/app/presentation/home/notifiers/state/home_state.dart';

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
      final initialList = [
        const Pokemon(name: 'Pikachu', url: 'www.google.com'),
        const Pokemon(name: 'Baseurl', url: 'www.google.com'),
      ];
      const updatedList = [
        Pokemon(name: 'Charmander', url: 'www.google.com'),
      ];

      final state = HomeState(pokemonList: initialList);

      final updatedState = state.copyWith(pokemonList: updatedList);

      expect(updatedState.pokemonList, updatedList);
      expect(state.pokemonList, initialList);
    });

    test('copyWith returns the same instance if no changes are made', () {
      const initialList = [
        Pokemon(name: 'Pikachu', url: 'www.google.com'),
      ];

      const state = HomeState(pokemonList: initialList);

      final updatedState = state.copyWith();

      expect(updatedState.pokemonList, initialList);
      expect(updatedState, state);
    });
  });
}
