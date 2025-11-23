import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final String id;
  @JsonKey(name: 'deal_id')
  final String dealId;
  final int quantity;
  @JsonKey(name: 'total_price')
  final double totalPrice;
  final String status; // PENDING, CONFIRMED, CANCELLED
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  
  // Optional: Include deal details if backend provides it nested, 
  // or we might need to fetch it separately. 
  // For now, let's assume backend might send some deal info or we fetch it.
  // Adding basic deal info fields that might be useful for display
  @JsonKey(name: 'product_name')
  final String? productName;

  Order({
    required this.id,
    required this.dealId,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    this.productName,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
