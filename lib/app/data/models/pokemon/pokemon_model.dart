import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/app/domain/entities/pokemon/pokemon.dart';

part 'pokemon_model.g.dart';

@JsonSerializable()
class PokemonModel {
  const PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);

  factory PokemonModel.fromEntity(Pokemon pokemon) => PokemonModel(
        id: pokemon.id,
        name: pokemon.name,
        imageUrl: pokemon.imageUrl,
        types: List<String>.from(pokemon.types),
        height: pokemon.height,
        weight: pokemon.weight,
      );

  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;

  Map<String, dynamic> toJson() => _$PokemonModelToJson(this);

  Pokemon toEntity() => Pokemon(
        id: id,
        name: name,
        imageUrl: imageUrl,
        types: types,
        height: height,
        weight: weight,
      );
}
