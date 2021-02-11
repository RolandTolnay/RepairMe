import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TimeSlot extends Equatable {
  final TimeOfDay timeOfDay;
  final bool isBooked;

  const TimeSlot({
    @required this.timeOfDay,
    this.isBooked = false,
  });

  @override
  List<Object> get props => [timeOfDay.hour, timeOfDay.minute];
}
