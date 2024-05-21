import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/src/app/data/data_sources/remote/pokemon_remote_data_source.dart';
import 'package:home/src/app/data/models/pokemon/pokemon_model.dart';
import 'package:home/src/core/api/api_end_point.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pokemon_remote_data_source_test.mocks.dart';

// Generate mocks
@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late PokemonRemoteDataSourceImpl dataSource;

  setUp(() {
    mockDio = MockDio();
    dataSource = PokemonRemoteDataSourceImpl(mockDio);
  });

  group('fetchPokemon', () {
    test(
        'should return a list of PokemonModel when the call to API is successful',
        () async {
      // Arrange
      final responsePayload = {
        'results': [
          {'name': 'bulbasaur', 'url': 'https://pokeapi.co/api/v2/pokemon/1/'},
          {'name': 'ivysaur', 'url': 'https://pokeapi.co/api/v2/pokemon/2/'},
        ],
      };

      when(mockDio.get(APIEnPoint.getPokemon, queryParameters: {'limit': 20}))
          .thenAnswer(
        (_) async => Response(
          data: responsePayload,
          statusCode: 200,
          requestOptions: RequestOptions(path: APIEnPoint.getPokemon),
        ),
      );

      // Act
      final result =
          await dataSource.fetchPokemon(token: 'test_token', limit: 20);

      // Assert
      expect(result, isA<List<PokemonModel>>());
      expect(result.length, 2);
      expect(result[0].name, 'bulbasaur');
      expect(result[1].name, 'ivysaur');
    });

    test('should throw an Exception when the call to API fails', () async {
      // Arrange
      when(mockDio.get(APIEnPoint.getPokemon, queryParameters: {'limit': 20}))
          .thenThrow(
        DioException(
          requestOptions: RequestOptions(path: APIEnPoint.getPokemon),
          message: 'Something went wrong',
        ),
      );

      // Act & Assert
      expect(
        () => dataSource.fetchPokemon(token: 'test_token', limit: 20),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to load Pokemon'),
          ),
        ),
      );
    });
  });
}
