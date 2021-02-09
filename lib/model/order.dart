import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import 'component.dart';

class Order {
  final String id;
  final Component components;
  final int amount;

  Order({
    @required this.components,
    @required this.amount,
    id,
  }) : id = id ?? Uuid().v4();
}
