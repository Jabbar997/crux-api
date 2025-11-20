import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/deals_controller.dart';

class DealDetailsScreen extends ConsumerStatefulWidget {
  final String dealId;

  const DealDetailsScreen({super.key, required this.dealId});

  @override
  ConsumerState<DealDetailsScreen> createState() => _DealDetailsScreenState();
}

class _DealDetailsScreenState extends ConsumerState<DealDetailsScreen> {
  final _quantityController = TextEditingController(text: '1');

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  void _joinDeal() {
    final quantity = int.tryParse(_quantityController.text);
    if (quantity != null && quantity > 0) {
      ref.read(dealsControllerProvider.notifier).joinDeal(widget.dealId, quantity).then((_) {
        if (!mounted) return;
        if (!ref.read(dealsControllerProvider).hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully joined deal!')),
          );
          context.pop();
          // Refresh deals
          ref.invalidate(activeDealsProvider);
          ref.invalidate(futureDealsProvider);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dealAsync = ref.watch(dealDetailsProvider(widget.dealId));
    final dealsControllerState = ref.watch(dealsControllerProvider);

    ref.listen(dealsControllerProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Deal Details')),
      body: dealAsync.when(
        data: (deal) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (deal.imageUrl != null)
                Image.network(deal.imageUrl!, height: 200, width: double.infinity, fit: BoxFit.cover),
              const SizedBox(height: 16),
              Text(deal.productName, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text('Price: \$${deal.price}', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              Text('Status: ${deal.status}'),
              Text('Target: ${deal.targetQuantity}'),
              Text('Current: ${deal.currentQuantity}'),
              const SizedBox(height: 24),
              if (deal.status != 'COMPLETED') ...[
                TextField(
                  controller: _quantityController,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: dealsControllerState.isLoading ? null : _joinDeal,
                    child: dealsControllerState.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(deal.status == 'FUTURE' ? 'Pre-Order' : 'Join Deal'),
                  ),
                ),
              ],
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
