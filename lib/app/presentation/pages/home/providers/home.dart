import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/app/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/app/data/providers/home_provider.dart';
import 'package:pokedex/app/domain/entities/pokemon/pokemon.dart';
import 'package:pokedex/app/domain/use_cases/get_pokemon.dart';
import 'package:pokedex/app/presentation/pages/home/providers/state/home_state.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home.g.dart';

@riverpod
class Home extends _$Home {
  @override
  Future<HomeState> build() async {
    // state = const AsyncValue.data([4]);
    unawaited(fetchPokemon());
    return const HomeState.initial();
  }

  Future<void> fetchPokemon() async {
    final repository = ref.watch(pokemonRepositoryProvider);
    final response =
        await repository.fetchPokemon(GetPokemonParams(limit: 100));
    updateStateFromResponse(response);
  }

  void updateStateFromResponse(Either<Failure, List<Pokemon>> response) {
    response.fold((failure) {
      debugPrintStack(label: failure.message);
    }, (data) {
      final newState = state.value?.copyWith(
        pokemonList: data.map(PokemonModel.fromEntity).toList(),
      );
      state = AsyncData(newState ?? const HomeState.initial());
    });
  }
}
