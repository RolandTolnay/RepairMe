import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import 'order.dart';
import 'repair_shop.dart';

class Appointment {
  final String id;
  final DateTime date;
  final List<Order> orders;
  final RepairShop repairShop;

  Appointment({
    @required this.date,
    @required this.repairShop,
    this.orders = const [],
    id,
  }) : id = id ?? Uuid().v4();
}
