import 'package:dio/dio.dart';
import 'package:home/src/app/data/models/pokemon/pokemon_model.dart';
import 'package:home/src/core/api/api_end_point.dart';
import 'package:retrofit/retrofit.dart';

part 'pokemon_rtf_data_source.g.dart';

@RestApi()
abstract class PokemonRtfDataSource {
  factory PokemonRtfDataSource(Dio client) = _PokemonRtfDataSource;

  @GET(APIEnPoint.getPokemon)
  Future<List<PokemonModel>> fetchPokemon({
    @Header('Authorization') required String token,
    @Query('limit') int? limit,
    @Query('offset') int offset = 0,
  });
}
