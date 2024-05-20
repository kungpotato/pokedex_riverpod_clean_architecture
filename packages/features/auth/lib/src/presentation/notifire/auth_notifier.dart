import 'package:auth/src/presentation/notifire/state/auth_state.dart';
import 'package:core_providers/core_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<AuthState> build() async {
    state = const AsyncData(AuthState.initial());
    return const AuthState.initial();
  }

  void setUser(UserModel user) {
    state = AsyncValue.data(AuthState(user: user));
  }
}
