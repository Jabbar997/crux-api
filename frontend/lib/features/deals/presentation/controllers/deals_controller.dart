import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/deals_repository.dart';
import '../../data/models/deal.dart';

// Providers for fetching deals
final futureDealsProvider = FutureProvider<List<Deal>>((ref) async {
  final repository = ref.watch(dealsRepositoryProvider);
  return repository.getFutureDeals();
});

final activeDealsProvider = FutureProvider<List<Deal>>((ref) async {
  final repository = ref.watch(dealsRepositoryProvider);
  return repository.getActiveDeals();
});

final completedDealsProvider = FutureProvider<List<Deal>>((ref) async {
  final repository = ref.watch(dealsRepositoryProvider);
  return repository.getCompletedDeals();
});

final dealDetailsProvider = FutureProvider.family<Deal, String>((ref, id) async {
  final repository = ref.watch(dealsRepositoryProvider);
  return repository.getDealDetails(id);
});

// Controller for actions (joining deals)
final dealsControllerProvider = NotifierProvider<DealsController, AsyncValue<void>>(DealsController.new);

class DealsController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> joinDeal(String dealId, int quantity) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(dealsRepositoryProvider);
      await repository.joinDeal(dealId, quantity);
    });
  }
}
