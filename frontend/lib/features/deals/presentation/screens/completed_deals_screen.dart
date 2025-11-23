import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/deals_controller.dart';

class CompletedDealsScreen extends ConsumerWidget {
  const CompletedDealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dealsAsync = ref.watch(completedDealsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Completed Deals')),
      body: dealsAsync.when(
        data: (deals) => ListView.builder(
          itemCount: deals.length,
          itemBuilder: (context, index) {
            final deal = deals[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: deal.imageUrl != null
                    ? Image.network(deal.imageUrl!, width: 50, height: 50, fit: BoxFit.cover)
                    : const Icon(Icons.image, size: 50),
                title: Text(deal.productName),
                subtitle: const Text('Status: Completed'),
                trailing: const Icon(Icons.check_circle, color: Colors.green),
                onTap: () {
                  context.push('/deals/${deal.id}');
                },
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
