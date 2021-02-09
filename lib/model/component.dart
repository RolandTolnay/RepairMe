import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'component.g.dart';

@JsonSerializable()
class Component {
  final String id;
  final String name;
  final int price;

  Component({
    @required this.name,
    @required this.price,
    id,
  }) : id = id ?? Uuid().v4();

  factory Component.fromJson(Map<String, dynamic> json) =>
      _$ComponentFromJson(json);

  Map<String, dynamic> toJson() => _$ComponentToJson(this);
}
