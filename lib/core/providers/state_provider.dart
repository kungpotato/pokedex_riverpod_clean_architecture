enum ConcreteState {
  initial,
  loading,
  loaded,
  failure,
  fetchingMore,
  fetchedAllProducts
}

class StateProvider {
  const StateProvider(this.hasData, this.state, this.message, this.isLoading);

  const StateProvider.initial({
    this.isLoading = false,
    this.hasData = false,
    this.state = ConcreteState.initial,
    this.message = '',
  });

  final bool hasData;
  final ConcreteState state;
  final String message;
  final bool isLoading;

  StateProvider copyWith({
    bool? hasData,
    ConcreteState? state,
    String? message,
    bool? isLoading,
  }) {
    return StateProvider(
      hasData ?? this.hasData,
      state ?? this.state,
      message ?? this.message,
      isLoading ?? this.isLoading,
    );
  }
}
