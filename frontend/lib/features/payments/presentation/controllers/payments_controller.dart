import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/payments_repository.dart';

final paymentsControllerProvider = NotifierProvider<PaymentsController, AsyncValue<void>>(PaymentsController.new);

class PaymentsController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> createPayment(String orderId, double amount, String method) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(paymentsRepositoryProvider);
      await repository.createPayment(orderId, amount, method);
    });
  }
}
