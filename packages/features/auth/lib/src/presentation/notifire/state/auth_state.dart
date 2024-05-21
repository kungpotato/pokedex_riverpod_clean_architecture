import 'package:core_providers/core_providers.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  const AuthState({
    this.user,
  });

  const AuthState.initial({this.user});

  final UserModel? user;

  AuthState copyWith({
    UserModel? user,
  }) {
    return AuthState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [user];
}
