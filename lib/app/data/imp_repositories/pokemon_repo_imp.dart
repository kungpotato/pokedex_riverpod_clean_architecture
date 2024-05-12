import 'package:dartz/dartz.dart';
import 'package:pokedex/app/data/data_sources/local/user_local_data_source.dart';
import 'package:pokedex/app/data/data_sources/remote/pokemon_data_source/pokemon_remote_data_source.dart';
import 'package:pokedex/app/domain/entities/pokemon/pokemon.dart';
import 'package:pokedex/app/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/app/domain/use_cases/get_pokemon.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/core/network/network_info.dart';

class PokemonRepoImp extends PokemonRepository {
  PokemonRepoImp({
    required PokemonRemoteDataSource dataSource,
    required NetworkInfo networkInfo,
    required UserLocalDataSource userLocalDataSource,
  })  : _dataSource = dataSource,
        _networkInfo = networkInfo,
        _userLocalDataSource = userLocalDataSource;
  final PokemonRemoteDataSource _dataSource;
  final UserLocalDataSource _userLocalDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, List<Pokemon>>> fetchPokemon(
    GetPokemonParams params,
  ) async {
    if (await _networkInfo.isConnected) {
      if (await _userLocalDataSource.isTokenAvailable()) {
        final String token = await _userLocalDataSource.getToken();
        final data = await _dataSource.fetchPokemon(
          token: 'Bearer $token',
          limit: params.limit,
        );
        return Right(data.map((e) => e.toEntity()).toList());
      } else {
        return Left(NetworkFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
