import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/app/domain/entities/pokemon/pokemon.dart';
import 'package:pokedex/app/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/app/domain/use_cases/get_pokemon.dart';
import 'package:pokedex/app/presentation/common/state/main_state.dart';
import 'package:pokedex/app/presentation/pages/home/providers/state/home_state.dart';
import 'package:pokedex/core/error/failures.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier(
    this.pokemonRepository,
  ) : super(const HomeState.initial());
  final PokemonRepository pokemonRepository;

  bool get isFetching => state.state != ConcreteState.loading;

  Future<void> fetchPokemon(GetPokemonParams param) async {
    if (isFetching) {
      state = state.copyWith(
        state: ConcreteState.loading,
        isLoading: true,
      );
      final response = await pokemonRepository.fetchPokemon(param);
      updateStateFromResponse(response);
    } else {
      state = state.copyWith(
        state: ConcreteState.fetchedAllProducts,
        message: 'No data available',
        isLoading: false,
      );
    }
  }

  void updateStateFromResponse(Either<Failure, List<Pokemon>> response) {
    response.fold((failure) {
      state = state.copyWith(
        state: ConcreteState.failure,
        message: failure.message,
        isLoading: false,
      );
      debugPrintStack(label: failure.message);
    }, (data) {
      final List<PokemonModel> pokemonList = [
        ...state.pokemonList,
        ...data.map(PokemonModel.fromEntity),
      ];

      state = state.copyWith(
        pokemonList: pokemonList,
        state: ConcreteState.loaded,
        hasData: true,
        message: pokemonList.isEmpty ? 'No data found' : '',
        isLoading: false,
      );
    });
  }

  void resetState() {
    state = const HomeState.initial();
  }
}
