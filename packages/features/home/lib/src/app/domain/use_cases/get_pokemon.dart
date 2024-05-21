import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:home/src/app/domain/entities/pokemon/pokemon.dart';
import 'package:home/src/app/domain/repositories/pokemon_repository.dart';
import 'package:home/src/core/error/failures.dart';
import 'package:home/src/core/use_cases/use_case.dart';

class GetPokemon
    extends UseCase<GetPokemonParams, Either<Failure, List<Pokemon>>> {
  GetPokemon(this.repository);

  final PokemonRepository repository;

  @override
  Future<Either<Failure, List<Pokemon>>> call(GetPokemonParams params) {
    return repository.fetchPokemon(params);
  }
}

class GetPokemonParams extends Equatable {
  const GetPokemonParams({
    required this.limit,
  });

  final int limit;

  @override
  List<Object?> get props => [limit];
}
