import 'package:pokedex/app/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/app/domain/entities/pokemon/pokemon.dart';

extension PokemonModelMapper on List<Map<String, dynamic>> {
  List<PokemonModel> toPokemonModelList() {
    return map(PokemonModel.fromJson).toList();
  }
}

extension PokemonEntityList on List<Pokemon> {
  List<PokemonModel> fromPokemonEntity() {
    return map(PokemonModel.fromEntity).toList();
  }
}

extension PokemonModelList on List<PokemonModel> {
  List<Pokemon> toPokemonEntity() {
    return map((e) => e.toEntity()).toList();
  }
}
