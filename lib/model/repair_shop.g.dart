// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepairShop _$RepairShopFromJson(Map<String, dynamic> json) {
  return RepairShop(
    name: json['name'] as String,
    distance: json['distance'] as int,
    rating: (json['rating'] as num)?.toDouble(),
    price: json['price'] as int,
    id: json['id'],
    logoUrl: json['logoUrl'] as String,
  );
}

Map<String, dynamic> _$RepairShopToJson(RepairShop instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logoUrl': instance.logoUrl,
      'rating': instance.rating,
      'distance': instance.distance,
      'price': instance.price,
    };
