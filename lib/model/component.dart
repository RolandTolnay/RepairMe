import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class Component {
  final String id;
  final String name;
  final int price;

  Component({
    @required this.name,
    @required this.price,
    id,
  }) : id = id ?? Uuid().v4();
}
