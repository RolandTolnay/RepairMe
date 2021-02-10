import 'dart:collection';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../model/date_time_utility.dart';

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

abstract class DateTimeProvider extends ChangeNotifier {
  DateTime get selectedDate;
  TimeSlot get selectedTimeSlot;

  UnmodifiableListView<TimeSlot> get timeSlots;

  void selectDate(DateTime date);
  void selectTimeSlot(TimeSlot slot);
}

class RMDateTimeProvider extends ChangeNotifier implements DateTimeProvider {
  DateTime _selectedDate = DateTime.now();
  TimeSlot _selectedTimeSlot;
  List<TimeSlot> _timeSlots = [];

  @override
  DateTime get selectedDate => _selectedDate;

  @override
  TimeSlot get selectedTimeSlot => _selectedTimeSlot;

  @override
  UnmodifiableListView<TimeSlot> get timeSlots =>
      UnmodifiableListView(_timeSlots);

  RMDateTimeProvider() {
    _timeSlots = _timeSlotsForDate(_selectedDate);
  }

  @override
  void selectDate(DateTime date) {
    _selectedDate = date;
    _timeSlots = _timeSlotsForDate(date);
    _selectedTimeSlot = null;
    notifyListeners();
  }

  @override
  void selectTimeSlot(TimeSlot slot) {
    _selectedTimeSlot = slot;
  }

  List<TimeSlot> _timeSlotsForDate(DateTime date) {
    // Sunday closed
    if (date.weekday == 7) return [];

    final interval = Duration(minutes: 15);
    final openingTime = TimeOfDay(hour: 9, minute: 0);
    final closingTime = TimeOfDay(hour: 18, minute: 0);
    final randomGenerator = Random();

    final timeSlots = <TimeSlot>[];
    var currentTime = openingTime;
    while (closingTime > currentTime) {
      final slot = TimeSlot(
        timeOfDay: currentTime,
        isBooked: randomGenerator.nextBool(),
      );
      timeSlots.add(slot);
      currentTime = currentTime.addingDuration(interval);
    }
    return timeSlots;
  }
}

extension on TimeOfDay {
  bool operator >(TimeOfDay timeOfDay) {
    if (hour == timeOfDay.hour) {
      return minute > timeOfDay.minute;
    } else {
      return hour > timeOfDay.hour;
    }
  }

  TimeOfDay addingDuration(Duration duration) {
    final addedMinutes = duration.inMinutes + hour * 60 + minute;
    var resultHours = addedMinutes ~/ 60;
    if (resultHours > 23) {
      resultHours -= 24;
    }
    return TimeOfDay(hour: resultHours, minute: addedMinutes % 60);
  }
}
