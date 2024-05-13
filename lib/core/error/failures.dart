abstract class Failure {
  Failure({this.message});

  String? message;
}

// General failures
class ServerFailure extends Failure {
  ServerFailure({super.message});
}

class NetworkFailure extends Failure {
  NetworkFailure({super.message});
}

class CacheFailure extends Failure {}

class ExceptionFailure extends Failure {}

class CredentialFailure extends Failure {}

class AuthenticationFailure extends Failure {}
