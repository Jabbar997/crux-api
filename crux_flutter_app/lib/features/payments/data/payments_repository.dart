import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/network/api_service.dart';
import '../../../core/errors/app_exception.dart';

final paymentsRepositoryProvider = Provider<PaymentsRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return PaymentsRepository(apiService);
});

class PaymentsRepository {
  final ApiService _apiService;

  PaymentsRepository(this._apiService);

  Future<void> createPayment(String orderId, double amount, String method) async {
    try {
      await _apiService.createPayment({
        'order_id': orderId,
        'amount': amount,
        'method': method,
      });
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? 'Payment failed');
    } catch (e) {
      throw ServerException('An unexpected error occurred');
    }
  }
}
