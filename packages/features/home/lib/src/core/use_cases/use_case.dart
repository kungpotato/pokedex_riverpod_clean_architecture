abstract class UseCase<P, T> {
  Future<T?> call(P params);
}

abstract class NoParamsUseCase<T> extends UseCase<void, T> {
  @override
  Future<T?> call(void params);
}

abstract class UseCaseStream<P, T> {
  Stream<T?> call(P params);
}

abstract class NoParamsUseCaseStream<T> extends UseCaseStream<void, T> {
  @override
  Stream<T?> call(void params);
}
