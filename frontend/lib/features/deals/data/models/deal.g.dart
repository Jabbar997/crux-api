// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deal _$DealFromJson(Map<String, dynamic> json) => Deal(
  id: json['id'] as String,
  productName: json['product_name'] as String,
  imageUrl: json['image_url'] as String?,
  targetQuantity: (json['target_quantity'] as num).toInt(),
  currentQuantity: (json['current_quantity'] as num).toInt(),
  status: json['status'] as String,
  startDate: DateTime.parse(json['start_date'] as String),
  endDate: DateTime.parse(json['end_date'] as String),
  price: (json['price'] as num).toDouble(),
);

Map<String, dynamic> _$DealToJson(Deal instance) => <String, dynamic>{
  'id': instance.id,
  'product_name': instance.productName,
  'image_url': instance.imageUrl,
  'target_quantity': instance.targetQuantity,
  'current_quantity': instance.currentQuantity,
  'status': instance.status,
  'start_date': instance.startDate.toIso8601String(),
  'end_date': instance.endDate.toIso8601String(),
  'price': instance.price,
};
