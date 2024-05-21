import 'package:dartz/dartz.dart';
import 'package:home/src/app/domain/entities/pokemon/pokemon.dart';
import 'package:home/src/app/domain/use_cases/get_pokemon.dart';
import 'package:home/src/core/error/failures.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<Pokemon>>> fetchPokemon(GetPokemonParams params);
}
