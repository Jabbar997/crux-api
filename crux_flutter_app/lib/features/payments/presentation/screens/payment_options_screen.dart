import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/payments_controller.dart';

class PaymentOptionsScreen extends ConsumerStatefulWidget {
  final String orderId;
  final double amount;

  const PaymentOptionsScreen({
    super.key,
    required this.orderId,
    required this.amount,
  });

  @override
  ConsumerState<PaymentOptionsScreen> createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends ConsumerState<PaymentOptionsScreen> {
  String _selectedMethod = 'CREDIT_CARD';

  void _processPayment() {
    ref.read(paymentsControllerProvider.notifier).createPayment(
          widget.orderId,
          widget.amount,
          _selectedMethod,
        ).then((_) {
          if (!mounted) return;
          if (!ref.read(paymentsControllerProvider).hasError) {
            context.go('/payment/success');
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final paymentState = ref.watch(paymentsControllerProvider);

    ref.listen(paymentsControllerProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total Amount: \$${widget.amount}',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            const Text('Select Payment Method:'),
            const SizedBox(height: 16),
            // ignore: deprecated_member_use
            RadioListTile<String>(
              title: const Text('Credit Card'),
              value: 'CREDIT_CARD',
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value!;
                });
              },
            ),
            // ignore: deprecated_member_use
            RadioListTile<String>(
              title: const Text('Apple Pay'),
              value: 'APPLE_PAY',
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value!;
                });
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: paymentState.isLoading ? null : _processPayment,
              child: paymentState.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}
