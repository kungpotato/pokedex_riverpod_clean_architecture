import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/app/domain/entities/pokemon/pokemon.dart';
import 'package:pokedex/app/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/app/domain/use_cases/get_pokemon.dart';
import 'package:pokedex/core/error/failures.dart';

import 'get_pokemon_test.mocks.dart';

@GenerateMocks([PokemonRepository, GetPokemonParams, GetPokemon])
void main() {
  late GetPokemon getPokemon;
  late PokemonRepository mockPokemonRepository;
  late GetPokemonParams getPokemonParams;

  const tLimit = 10;
  final tPokemonParams = GetPokemonParams(limit: tLimit);
  final tPokemonList = List<Pokemon>.generate(
    tLimit,
    (index) => Pokemon(name: 'Pokemon $index', url: 'www.google.com'),
  );

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    getPokemonParams = MockGetPokemonParams();
    getPokemon = MockGetPokemon();

    when(getPokemon(getPokemonParams))
        .thenAnswer((_) async => Right(tPokemonList));
  });

  test(
      'should return a list of Pokemon when the call to repository is successful',
      () async {
    // Arrange
    when(mockPokemonRepository.fetchPokemon(getPokemonParams))
        .thenAnswer((_) async => Right(tPokemonList));

    // Act
    final result = await getPokemon(getPokemonParams);

    // Assert
    expect(result, Right(tPokemonList));
    verify(mockPokemonRepository.fetchPokemon(tPokemonParams));
    verifyNoMoreInteractions(mockPokemonRepository);
  });

  test('should return a failure when the call to repository is unsuccessful',
      () async {
    // Arrange
    when(mockPokemonRepository.fetchPokemon(getPokemonParams))
        .thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await getPokemon(getPokemonParams);

    // Assert
    expect(result, Left(isA<ServerFailure>()));
    verify(mockPokemonRepository.fetchPokemon(tPokemonParams));
    verifyNoMoreInteractions(mockPokemonRepository);
  });
}
