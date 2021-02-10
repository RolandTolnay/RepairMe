import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension Utility on DateTime {
  /// February 10
  String get dateDescription => '${DateFormat.MMMMd().format(this)}';

  DateTime withTimeOfDay(TimeOfDay timeOfDay) =>
      DateTime(year, month, day, timeOfDay.hour, timeOfDay.minute);
}
