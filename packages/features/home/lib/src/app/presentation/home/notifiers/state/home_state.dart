import 'package:equatable/equatable.dart';
import 'package:home/src/app/data/models/pokemon/pokemon_model.dart';

class HomeState extends Equatable {
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

  @override
  List<Object?> get props => [pokemonList];
}
