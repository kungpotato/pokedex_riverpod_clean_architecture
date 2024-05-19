//date
class ServerException implements Exception {}

class CacheException implements Exception {}

//route
class RouteException implements Exception {
  const RouteException(this.message);

  final String message;
}
