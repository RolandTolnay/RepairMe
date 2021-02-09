import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class RepairShop {
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
}
