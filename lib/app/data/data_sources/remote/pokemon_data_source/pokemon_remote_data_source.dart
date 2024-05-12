import 'package:dio/dio.dart';
import 'package:pokedex/app/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/core/api/api_end_point.dart';
import 'package:retrofit/retrofit.dart';

part 'pokemon_remote_data_source.g.dart';

@RestApi()
abstract class PokemonRemoteDataSource {
  factory PokemonRemoteDataSource(Dio client) = _PokemonRemoteDataSource;

  @GET(APIEnPoint.getPokemon)
  Future<List<PokemonModel>> fetchPokemon({
    @Header('Authorization') required String token,
    @Query('limit') int? limit,
    @Query('offset') int offset = 0,
  });
}
