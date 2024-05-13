import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/data/providers/home_provider.dart';
import 'package:pokedex/app/domain/use_cases/get_pokemon.dart';
import 'package:pokedex/app/presentation/pages/home/providers/state/home_notifier.dart';
import 'package:pokedex/app/presentation/pages/home/providers/state/home_state.dart';

final homeNotifierProvider =
    AutoDisposeStateNotifierProvider<HomeNotifier, HomeState>(
  (ref) => HomeNotifier(ref.watch(pokemonRepositoryProvider))
    ..fetchPokemon(GetPokemonParams(limit: 100)),
);
