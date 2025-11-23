import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/deals_controller.dart';

class ActiveDealsScreen extends ConsumerWidget {
  const ActiveDealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dealsAsync = ref.watch(activeDealsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Active Deals')),
      body: dealsAsync.when(
        data: (deals) => ListView.builder(
          itemCount: deals.length,
          itemBuilder: (context, index) {
            final deal = deals[index];
            final progress = deal.currentQuantity / deal.targetQuantity;
            
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    leading: deal.imageUrl != null
                        ? Image.network(deal.imageUrl!, width: 50, height: 50, fit: BoxFit.cover)
                        : const Icon(Icons.image, size: 50),
                    title: Text(deal.productName),
                    subtitle: Text('Ends: ${deal.endDate.toString().split(' ')[0]}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LinearProgressIndicator(value: progress),
                        const SizedBox(height: 4),
                        Text('${deal.currentQuantity} / ${deal.targetQuantity} units'),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              context.push('/deals/${deal.id}');
                            },
                            child: const Text('Join Deal'),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
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
