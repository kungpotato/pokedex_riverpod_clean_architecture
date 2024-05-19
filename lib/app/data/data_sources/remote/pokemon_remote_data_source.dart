import 'package:dio/dio.dart';
import 'package:pokedex/app/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/core/api/api_end_point.dart';
import 'package:pokedex/core/utils/mapper.dart';

abstract class PokemonRemoteDataSource {
  PokemonRemoteDataSource(Dio client) : _client = client;
  final Dio _client;

  Future<List<PokemonModel>> fetchPokemon({
    required String token,
    required int limit,
  });
}

class PokemonRemoteDataSourceImpl extends PokemonRemoteDataSource {
  PokemonRemoteDataSourceImpl(super.client);

  @override
  Future<List<PokemonModel>> fetchPokemon({
    required String token,
    required int limit,
  }) async {
    try {
      final response = await _client
          .get(APIEnPoint.getPokemon, queryParameters: {'limit': 20});
      final data = response.data['results'] as List<dynamic>;
      return data.toPokemonModelList();
    } on DioException catch (e) {
      throw Exception('Failed to load Pokemon: ${e.message}');
    }
  }
}
