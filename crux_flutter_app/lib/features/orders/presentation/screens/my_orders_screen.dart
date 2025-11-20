import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/orders_controller.dart';


class MyOrdersScreen extends ConsumerWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: ordersAsync.when(
        data: (orders) => ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(order.productName ?? 'Order #${order.id.substring(0, 8)}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Quantity: ${order.quantity}'),
                    Text('Total: \$${order.totalPrice}'),
                    Text('Date: ${order.createdAt.toString().split(' ')[0]}'),
                  ],
                ),
                trailing: Chip(
                  label: Text(order.status),
                  backgroundColor: _getStatusColor(order.status),
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'PENDING':
        return Colors.orange.shade100;
      case 'CONFIRMED':
        return Colors.green.shade100;
      case 'CANCELLED':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }
}
