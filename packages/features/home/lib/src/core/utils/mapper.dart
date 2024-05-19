import 'package:home/src/app/data/models/pokemon/pokemon_model.dart';
import 'package:home/src/app/domain/entities/pokemon/pokemon.dart';

extension PokemonModelMapper on List<dynamic> {
  List<PokemonModel> toPokemonModelList() {
    return map((e) => PokemonModel.fromJson(e as Map<String, dynamic>))
        .toList();
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
