// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
  id: json['id'] as String,
  dealId: json['deal_id'] as String,
  quantity: (json['quantity'] as num).toInt(),
  totalPrice: (json['total_price'] as num).toDouble(),
  status: json['status'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  productName: json['product_name'] as String?,
);

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'id': instance.id,
  'deal_id': instance.dealId,
  'quantity': instance.quantity,
  'total_price': instance.totalPrice,
  'status': instance.status,
  'created_at': instance.createdAt.toIso8601String(),
  'product_name': instance.productName,
};
