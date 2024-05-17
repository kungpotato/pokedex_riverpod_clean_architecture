import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/app/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/app/domain/entities/pokemon/pokemon.dart';
import 'package:pokedex/app/domain/use_cases/get_pokemon.dart';
import 'package:pokedex/app/presentation/home/notifiers/state/home_state.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/core/providers/repository/pokemon_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_notifier.g.dart';

@riverpod
class HomeNotifier extends _$HomeNotifier {
  @override
  Future<HomeState> build() async {
    state = const AsyncData(HomeState.initial());

    return fetchPokemon(const GetPokemonParams(limit: 100));
  }

  Future<HomeState> fetchPokemon(GetPokemonParams param) async {
    final getPokemon = GetPokemon(ref.watch(pokemonRepositoryProvider));
    final response = await getPokemon(param);
    return updateStateFromResponse(response);
  }

  Future<HomeState> updateStateFromResponse(
    Either<Failure, List<Pokemon>> response,
  ) async {
    return await response.fold((failure) {
      debugPrintStack(label: failure.message);
      throw Exception(failure);
    }, (data) {
      final newState = state.value?.copyWith(
        pokemonList: data.map(PokemonModel.fromEntity).toList(),
      );
      return Future.value(newState ?? const HomeState.initial());
    });
  }
}
