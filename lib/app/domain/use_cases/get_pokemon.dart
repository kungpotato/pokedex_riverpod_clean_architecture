import 'package:dartz/dartz.dart';
import 'package:pokedex/app/domain/entities/pokemon/pokemon.dart';
import 'package:pokedex/app/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/core/use_cases/use_case.dart';

class GetPokemon
    extends UseCase<GetPokemonParams, Either<Failure, List<Pokemon>>> {
  GetPokemon(this.repository);

  final PokemonRepository repository;

  @override
  Future<Either<Failure, List<Pokemon>>> call(GetPokemonParams params) {
    return repository.fetchPokemon(params);
  }
}

class GetPokemonParams {
  GetPokemonParams({
    required this.test,
  });

  final String test;
}
