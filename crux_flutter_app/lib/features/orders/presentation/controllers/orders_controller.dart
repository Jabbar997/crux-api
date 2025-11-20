import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/orders_repository.dart';
import '../../data/models/order.dart';

final ordersProvider = FutureProvider<List<Order>>((ref) async {
  final repository = ref.watch(ordersRepositoryProvider);
  return repository.getMyOrders();
});
