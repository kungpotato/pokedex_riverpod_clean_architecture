import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/app/domain/entities/pokemon/pokemon.dart';
import 'package:pokedex/app/domain/use_cases/get_pokemon.dart';
import 'package:pokedex/app/presentation/home/notifiers/state/home_state.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/core/providers/repository/pokemon_repository_provider.dart';
import 'package:pokedex/core/utils/mapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_notifier.g.dart';

@riverpod
class HomeNotifier extends _$HomeNotifier {
  @override
  Future<HomeState> build() async {
    state = const AsyncData(HomeState.initial());
    state = const AsyncLoading<HomeState>();
    final getPokemon = GetPokemon(ref.read(pokemonRepositoryProvider));
    return fetchPokemon(getPokemon);
  }

  Future<HomeState> fetchPokemon(GetPokemon getPokemon) async {
    final response = await getPokemon(const GetPokemonParams(limit: 100));
    await Future.delayed(const Duration(seconds: 3));
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
        pokemonList: data.fromPokemonEntity(),
      );
      return Future.value(newState ?? const HomeState.initial());
    });
  }
}

class HomeNotifierMock extends _$HomeNotifier
    with Mock
    implements HomeNotifier {}
