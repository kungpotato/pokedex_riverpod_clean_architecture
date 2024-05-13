import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/app/domain/entities/pokemon/pokemon.dart';

part 'pokemon_model.g.dart';

@JsonSerializable()
class PokemonModel {
  const PokemonModel({
    required this.name,
    required this.url,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);

  factory PokemonModel.fromEntity(Pokemon pokemon) => PokemonModel(
        name: pokemon.name,
        url: pokemon.url,
      );

  final String name;
  final String url;

  Map<String, dynamic> toJson() => _$PokemonModelToJson(this);

  Pokemon toEntity() => Pokemon(name: name, url: url);

  String get imgUrl {
    final segments = url.split('/');
    segments.removeWhere((s) => s.isEmpty);
    final String id = segments[segments.length - 1];
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  }
}
