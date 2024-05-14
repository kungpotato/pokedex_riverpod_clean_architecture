import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/app/domain/entities/pokemon/pokemon.dart';
import 'package:pokedex/app/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/app/domain/use_cases/get_pokemon.dart';
import 'package:pokedex/app/presentation/pages/home/home_page.dart';
import 'package:pokedex/app/presentation/pages/home/providers/home_notifier.dart';
import 'package:pokedex/core/providers/network_provider.dart';
import 'package:pokedex/core/providers/storage_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page_test.mocks.dart';

@GenerateMocks([
  GetPokemonParams,
  PokemonRepository,
  GetPokemon,
  InternetConnectionChecker,
  SharedPreferences,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late InternetConnectionChecker internetConnectionChecker;
  late SharedPreferences sharedPreferences;

  late PokemonRepository mockPokemonRepository;
  late GetPokemonParams getPokemonParams;
  late GetPokemon getPokemon;

  const tLimit = 10;
  final tPokemonList = List<Pokemon>.generate(
    tLimit,
    (index) => Pokemon(name: 'Pokemon $index', url: 'www.google.com'),
  );

  setUp(() {
    internetConnectionChecker = MockInternetConnectionChecker();
    sharedPreferences = MockSharedPreferences();

    mockPokemonRepository = MockPokemonRepository();
    getPokemonParams = MockGetPokemonParams();
    getPokemon = GetPokemon(mockPokemonRepository);
  });

  testWidgets('Show pokemon list', (tester) async {
    when(internetConnectionChecker.hasConnection).thenAnswer((_) async => true);

    when(getPokemon(getPokemonParams)).thenAnswer(
      (_) async => Right(tPokemonList),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          internetConnectionCheckerProvider
              .overrideWithValue(internetConnectionChecker),
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
          homeNotifierProvider.overrideWith(MockHomeNotifier.new),
        ],
        child: const MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    await tester.pumpAndSettle(const Duration(seconds: 2));

    for (var i = 0; i < tLimit; i++) {
      expect(find.text('Pokemon $i'), findsOneWidget);
    }
  });
}
