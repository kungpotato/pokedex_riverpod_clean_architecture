import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:home/src/app/domain/entities/pokemon/pokemon.dart';
import 'package:home/src/app/domain/use_cases/get_pokemon.dart';
import 'package:home/src/app/presentation/home/notifiers/state/home_state.dart';
import 'package:home/src/core/error/failures.dart';
import 'package:home/src/core/providers/repository/pokemon_repository_provider.dart';
import 'package:mockito/mockito.dart';
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
        pokemonList: data,
      );
      return Future.value(newState ?? const HomeState.initial());
    });
  }
}

class HomeNotifierMock extends _$HomeNotifier
    with Mock
    implements HomeNotifier {}
