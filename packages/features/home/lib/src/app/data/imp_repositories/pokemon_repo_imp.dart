import 'package:core_providers/core_providers.dart';
import 'package:dartz/dartz.dart';
import 'package:home/src/app/data/data_sources/local/user_local_data_source.dart';
import 'package:home/src/app/data/data_sources/remote/pokemon_remote_data_source.dart';
import 'package:home/src/app/domain/entities/pokemon/pokemon.dart';
import 'package:home/src/app/domain/repositories/pokemon_repository.dart';
import 'package:home/src/app/domain/use_cases/get_pokemon.dart';
import 'package:home/src/core/error/failures.dart';

class PokemonRepoImp extends PokemonRepository {
  PokemonRepoImp({
    required PokemonRemoteDataSourceImpl remoteDataSource,
    required NetworkInfo networkInfo,
    required UserLocalDataSource userLocalDataSource,
  })  : _dataSource = remoteDataSource,
        _networkInfo = networkInfo,
        _userLocalDataSource = userLocalDataSource;
  final PokemonRemoteDataSourceImpl _dataSource;
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
        return const Left(NetworkFailure(message: 'no data available'));
      }
    } else {
      return const Left(NetworkFailure(message: 'no data available'));
    }
  }
}
