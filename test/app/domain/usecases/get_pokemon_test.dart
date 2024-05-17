import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/app/domain/entities/pokemon/pokemon.dart';
import 'package:pokedex/app/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/app/domain/use_cases/get_pokemon.dart';
import 'package:pokedex/core/error/failures.dart';

import 'get_pokemon_test.mocks.dart';

@GenerateMocks([PokemonRepository, GetPokemonParams])
void main() {
  late PokemonRepository mockPokemonRepository;
  late GetPokemonParams getPokemonParams;
  late GetPokemon getPokemon;

  const tLimit = 10;
  final tPokemonList = List<Pokemon>.generate(
    tLimit,
    (index) => Pokemon(name: 'Pokemon $index', url: 'www.google.com'),
  );

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    getPokemonParams = MockGetPokemonParams();
    getPokemon = GetPokemon(mockPokemonRepository);
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
    verify(mockPokemonRepository.fetchPokemon(getPokemonParams)).called(1);
    // verifyNoMoreInteractions(mockPokemonRepository);
  });

  test('should return a failure when the call to repository is unsuccessful',
      () async {
    // Arrange
    when(mockPokemonRepository.fetchPokemon(getPokemonParams))
        .thenAnswer((_) async => const Left(NetworkFailure()));

    // Act
    final result = await getPokemon(getPokemonParams);

    // Assert
    expect(result, const Left(NetworkFailure()));
    verify(mockPokemonRepository.fetchPokemon(getPokemonParams)).called(1);
    // verifyNoMoreInteractions(mockPokemonRepository);
  });
}
