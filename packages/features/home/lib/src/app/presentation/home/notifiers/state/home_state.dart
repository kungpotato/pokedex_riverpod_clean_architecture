import 'package:equatable/equatable.dart';
import 'package:home/src/app/domain/entities/pokemon/pokemon.dart';

class HomeState extends Equatable {
  const HomeState({
    this.pokemonList = const [],
  });

  const HomeState.initial({this.pokemonList = const []});

  final List<Pokemon> pokemonList;

  HomeState copyWith({
    List<Pokemon>? pokemonList,
  }) {
    return HomeState(
      pokemonList: pokemonList ?? this.pokemonList,
    );
  }

  @override
  List<Object?> get props => [pokemonList];
}
