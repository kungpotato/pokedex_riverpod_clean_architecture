import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({super.message});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message});
}

class ExceptionFailure extends Failure {
  const ExceptionFailure({super.message});
}

class CredentialFailure extends Failure {
  const CredentialFailure({super.message});
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({super.message});
}
