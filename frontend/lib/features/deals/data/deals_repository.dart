import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/network/api_service.dart';
import '../../../core/errors/app_exception.dart';
import 'models/deal.dart';

final dealsRepositoryProvider = Provider<DealsRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return DealsRepository(apiService);
});

class DealsRepository {
  final ApiService _apiService;

  DealsRepository(this._apiService);

  Future<List<Deal>> getFutureDeals() async {
    try {
      final response = await _apiService.getFutureDeals();
      final List<dynamic> data = response.data;
      return data.map((json) => Deal.fromJson(json)).toList();
    } catch (e) {
      throw ServerException('Failed to fetch future deals');
    }
  }

  Future<List<Deal>> getActiveDeals() async {
    try {
      final response = await _apiService.getActiveDeals();
      final List<dynamic> data = response.data;
      return data.map((json) => Deal.fromJson(json)).toList();
    } catch (e) {
      throw ServerException('Failed to fetch active deals');
    }
  }

  Future<List<Deal>> getCompletedDeals() async {
    try {
      final response = await _apiService.getCompletedDeals();
      final List<dynamic> data = response.data;
      return data.map((json) => Deal.fromJson(json)).toList();
    } catch (e) {
      throw ServerException('Failed to fetch completed deals');
    }
  }

  Future<Deal> getDealDetails(String id) async {
    try {
      final response = await _apiService.getDealDetails(id);
      return Deal.fromJson(response.data);
    } catch (e) {
      throw ServerException('Failed to fetch deal details');
    }
  }

  Future<void> joinDeal(String dealId, int quantity) async {
    try {
      await _apiService.createOrder({
        'deal_id': dealId,
        'quantity': quantity,
      });
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? 'Failed to join deal');
    } catch (e) {
      throw ServerException('An unexpected error occurred');
    }
  }
}
