enum ConcreteState {
  initial,
  loading,
  loaded,
  failure,
  fetchingMore,
  fetchedAllProducts
}

class MainState {
  const MainState(this.hasData, this.state, this.message, this.isLoading);

  const MainState.initial({
    this.isLoading = false,
    this.hasData = false,
    this.state = ConcreteState.initial,
    this.message = '',
  });

  final bool hasData;
  final ConcreteState state;
  final String message;
  final bool isLoading;

  MainState copyWith({
    bool? hasData,
    ConcreteState? state,
    String? message,
    bool? isLoading,
  }) {
    return MainState(
      hasData ?? this.hasData,
      state ?? this.state,
      message ?? this.message,
      isLoading ?? this.isLoading,
    );
  }
}
