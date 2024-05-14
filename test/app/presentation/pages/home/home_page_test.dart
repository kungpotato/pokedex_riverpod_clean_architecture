import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/app/domain/entities/pokemon/pokemon.dart';
import 'package:pokedex/app/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/app/domain/use_cases/get_pokemon.dart';
import 'package:pokedex/app/presentation/pages/home/home_page.dart';
import 'package:pokedex/app/presentation/pages/home/providers/home_notifier.dart';

import 'home_page_test.mocks.dart';

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  addTearDown(container.dispose);

  return container;
}

@GenerateMocks([GetPokemonParams, PokemonRepository, GetPokemon])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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

  testWidgets('Show pokemon list', (tester) async {
    const page = HomePage();

    // final container = createContainer(
    //   overrides: [homeNotifierProvider.overrideWith(MockHomeNotifier.new)],
    // );
    //
    // final mockHomeNotifier = container.read(homeNotifierProvider.notifier);
    // await mockHomeNotifier.fetchPokemon();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [homeNotifierProvider.overrideWith(MockHomeNotifier.new)],
        child: const MaterialApp(
          home: page,
        ),
      ),
    );

    when(getPokemon(getPokemonParams)).thenAnswer(
      (_) async => Right(tPokemonList),
    );

    final context = tester.element(find.byWidget(page));
    final container = ProviderScope.containerOf(context);

    await container.read(homeNotifierProvider.notifier).fetchPokemon();
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(
      container.read(homeNotifierProvider).value?.pokemonList,
      tPokemonList,
    );
  });
}
