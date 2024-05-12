import 'package:dartz/dartz.dart';
import 'package:pokedex/app/domain/entities/pokemon/pokemon.dart';
import 'package:pokedex/app/domain/use_cases/get_pokemon.dart';
import 'package:pokedex/core/error/failures.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<Pokemon>>> fetchPokemon(GetPokemonParams params);
}
