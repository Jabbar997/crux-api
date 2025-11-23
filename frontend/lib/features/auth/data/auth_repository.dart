import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/network/api_service.dart';
import '../../../core/errors/app_exception.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthRepository(apiService);
});

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<String> login(String phone, String password) async {
    try {
      final response = await _apiService.login({
        'phone': phone,
        'password': password,
      });

      // Assuming backend returns { "access_token": "..." }
      return response.data['access_token'];
    } on DioException catch (e) {
      throw AuthException(
        e.response?.data['message'] ?? 'Login failed',
        e.response?.statusCode.toString(),
      );
    } catch (e) {
      throw AuthException('An unexpected error occurred');
    }
  }

  Future<void> register(
    String name,
    String phone,
    String email,
    String password,
    String role,
  ) async {
    try {
      await _apiService.register({
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'role': role,
      });
    } on DioException catch (e) {
      throw AuthException(
        e.response?.data['message'] ?? 'Registration failed',
        e.response?.statusCode.toString(),
      );
    } catch (e) {
      throw AuthException('An unexpected error occurred');
    }
  }
}
