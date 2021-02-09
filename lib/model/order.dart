import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import 'component.dart';

class Order {
  final String id;
  final Component component;
  final int amount;

  Order({
    @required this.component,
    @required this.amount,
    id,
  }) : id = id ?? Uuid().v4();
}
