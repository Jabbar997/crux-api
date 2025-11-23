import 'package:json_annotation/json_annotation.dart';

part 'deal.g.dart';

@JsonSerializable()
class Deal {
  final String id;
  @JsonKey(name: 'product_name')
  final String productName;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'target_quantity')
  final int targetQuantity;
  @JsonKey(name: 'current_quantity')
  final int currentQuantity;
  final String status; // FUTURE, ACTIVE, COMPLETED
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @JsonKey(name: 'end_date')
  final DateTime endDate;
  final double price;

  Deal({
    required this.id,
    required this.productName,
    this.imageUrl,
    required this.targetQuantity,
    required this.currentQuantity,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.price,
  });

  factory Deal.fromJson(Map<String, dynamic> json) => _$DealFromJson(json);
  Map<String, dynamic> toJson() => _$DealToJson(this);
}
