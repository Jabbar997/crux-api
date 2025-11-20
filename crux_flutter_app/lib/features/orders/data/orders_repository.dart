import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/network/api_service.dart';
import '../../../core/errors/app_exception.dart';
import 'models/order.dart';

final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return OrdersRepository(apiService);
});

class OrdersRepository {
  final ApiService _apiService;

  OrdersRepository(this._apiService);

  Future<List<Order>> getMyOrders() async {
    try {
      final response = await _apiService.getOrders();
      final List<dynamic> data = response.data;
      return data.map((json) => Order.fromJson(json)).toList();
    } catch (e) {
      throw ServerException('Failed to fetch orders');
    }
  }

  // Future<Order> getOrderDetails(String id) async { ... } 
  // Not strictly needed if getMyOrders returns enough info, but good to have.
}
