import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'repair_shop.g.dart';

@JsonSerializable()
class RepairShop extends Equatable {
  final String id;
  final String name;
  final String logoUrl;

  final double rating;
  final int distance;
  final int price;

  RepairShop({
    @required this.name,
    @required this.distance,
    @required this.rating,
    @required this.price,
    id,
    this.logoUrl,
  }) : id = id ?? Uuid().v4();

  factory RepairShop.fromJson(Map<String, dynamic> json) =>
      _$RepairShopFromJson(json);

  Map<String, dynamic> toJson() => _$RepairShopToJson(this);

  @override
  List<Object> get props => [id];
}
