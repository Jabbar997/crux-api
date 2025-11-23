import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/network/dio_client.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(ref);
});
