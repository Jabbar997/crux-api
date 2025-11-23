import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/api_constants.dart';
import 'dio_client.dart';
import '../../shared/providers/dio_provider.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ApiService(dioClient);
});

class ApiService {
  final DioClient _dioClient;

  ApiService(this._dioClient);

  // Auth
  Future<Response> login(Map<String, dynamic> data) async {
    return await _dioClient.post(ApiConstants.login, data: data);
  }

  Future<Response> register(Map<String, dynamic> data) async {
    return await _dioClient.post(ApiConstants.register, data: data);
  }

  // Deals
  Future<Response> getFutureDeals() async {
    return await _dioClient.get(ApiConstants.dealsFuture);
  }

  Future<Response> getActiveDeals() async {
    return await _dioClient.get(ApiConstants.dealsActive);
  }

  Future<Response> getCompletedDeals() async {
    return await _dioClient.get(ApiConstants.dealsCompleted);
  }

  Future<Response> getDealDetails(String id) async {
    return await _dioClient.get('${ApiConstants.dealDetails}/$id');
  }

  // Orders
  Future<Response> createOrder(Map<String, dynamic> data) async {
    return await _dioClient.post(ApiConstants.orders, data: data);
  }

  Future<Response> getOrders() async {
    return await _dioClient.get(ApiConstants.orders);
  }

  // Payments
  Future<Response> createPayment(Map<String, dynamic> data) async {
    return await _dioClient.post(ApiConstants.payments, data: data);
  }
}
