import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:repairme/model/date_time_utility.dart';
import '../model/mocks.dart';

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

extension Convenience on DateTimeProvider {
  DateTime get commitedDateTime => selectedTimeSlot != null
      ? selectedDate.withTimeOfDay(selectedTimeSlot.timeOfDay)
      : null;
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
    _timeSlots = ModelMock.timeSlotListForDate(_selectedDate);
  }

  @override
  void selectDate(DateTime date) {
    _selectedDate = date;
    _timeSlots = ModelMock.timeSlotListForDate(date);
    _selectedTimeSlot = null;
    notifyListeners();
  }

  @override
  void selectTimeSlot(TimeSlot slot) {
    _selectedTimeSlot = slot;
    notifyListeners();
  }
}
