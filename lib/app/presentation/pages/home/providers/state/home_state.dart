import 'package:pokedex/app/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/core/providers/state_provider.dart';

class HomeState extends StateProvider {
  const HomeState({
    this.pokemonList = const [],
    bool hasData = false,
    ConcreteState state = ConcreteState.initial,
    String message = '',
    bool isLoading = false,
  }) : super(hasData, state, message, isLoading);

  const HomeState.initial({this.pokemonList = const []}) : super.initial();

  final List<PokemonModel> pokemonList;

  @override
  HomeState copyWith({
    List<PokemonModel>? pokemonList,
    bool? hasData,
    ConcreteState? state,
    String? message,
    bool? isLoading,
  }) {
    return HomeState(
      pokemonList: pokemonList ?? this.pokemonList,
      hasData: hasData ?? this.hasData,
      state: state ?? this.state,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
