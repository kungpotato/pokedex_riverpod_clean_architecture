import 'package:pokedex/app/data/models/pokemon/pokemon_model.dart';

class HomeState {
  const HomeState({
    this.pokemonList = const [],
  });

  const HomeState.initial({this.pokemonList = const []});

  final List<PokemonModel> pokemonList;

  HomeState copyWith({
    List<PokemonModel>? pokemonList,
  }) {
    return HomeState(
      pokemonList: pokemonList ?? this.pokemonList,
    );
  }
}
