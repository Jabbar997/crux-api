import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/auth_repository.dart';
import '../../data/token_storage.dart';

// Auth State (User is logged in or not)
final authStateProvider = NotifierProvider<AuthStateNotifier, bool>(AuthStateNotifier.new);

class AuthStateNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void setAuthenticated(bool value) {
    state = value;
  }
}

// Auth Controller (Handles actions)
final authControllerProvider = NotifierProvider<AuthController, AsyncValue<void>>(AuthController.new);

class AuthController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> checkAuthStatus() async {
    final tokenStorage = ref.read(tokenStorageProvider);
    final token = await tokenStorage.getToken();
    if (token != null) {
      ref.read(authStateProvider.notifier).setAuthenticated(true);
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authRepository = ref.read(authRepositoryProvider);
      final tokenStorage = ref.read(tokenStorageProvider);
      
      final token = await authRepository.login(email, password);
      await tokenStorage.saveToken(token);
      
      ref.read(authStateProvider.notifier).setAuthenticated(true);
    });
  }

  Future<void> register(String name, String email, String password, String role) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.register(name, email, password, role);
    });
  }

  Future<void> logout() async {
    final tokenStorage = ref.read(tokenStorageProvider);
    await tokenStorage.deleteToken();
    ref.read(authStateProvider.notifier).setAuthenticated(false);
  }
}
