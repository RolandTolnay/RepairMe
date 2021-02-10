import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/date_time_utility.dart';
import '../service/date_time_provider.dart';

class DateTimePickerPage extends StatelessWidget {
  final VoidCallback onDateTimePicked;

  const DateTimePickerPage({this.onDateTimePicked, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DateTimeProvider>();

    Widget content;
    if (provider.timeSlots.isEmpty) {
      content = Center(
          child: Text(
        'No timeslots available for this date.',
        style: Theme.of(context).textTheme.subtitle1,
      ));
    } else {
      content = GridView.count(
        childAspectRatio: 2,
        crossAxisCount: 3,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        children: provider.timeSlots.map((timeSlot) {
          return _TimeSlotButton(
            timeSlot,
            onTimeSlotPicked: (timeSlot) {
              provider.selectTimeSlot(timeSlot);
              onDateTimePicked?.call();
            },
          );
        }).toList(),
      );
    }

    return Column(
      children: [
        _DateSelector(
          provider.selectedDate,
          onDateSelected: (date) {
            provider.selectDate(date);
          },
        ),
        SizedBox(height: 32.0),
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: content,
        )
      ],
    );
  }
}

class _DateSelector extends StatelessWidget {
  const _DateSelector(this.date, {Key key, this.onDateSelected})
      : super(key: key);

  final DateTime date;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        '${date.dateDescription}',
        style: Theme.of(context).textTheme.headline5.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500),
      ),
      onTap: () async {
        final selectedDate = await showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime.fromMillisecondsSinceEpoch(0),
            lastDate: DateTime(2101));
        if (selectedDate != null) {
          onDateSelected?.call(selectedDate);
        }
      },
    );
  }
}

class _TimeSlotButton extends StatelessWidget {
  _TimeSlotButton(
    this.timeSlot, {
    this.onTimeSlotPicked,
    Key key,
  }) : super(key: key);

  final TimeSlot timeSlot;
  final ValueChanged<TimeSlot> onTimeSlotPicked;

  @override
  Widget build(BuildContext context) {
    final color = timeSlot.isBooked
        ? Theme.of(context).disabledColor
        : Theme.of(context).colorScheme.primaryVariant;
    final textStyle = Theme.of(context).textTheme.subtitle1.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
        );
    final timeDescription = MaterialLocalizations.of(context).formatTimeOfDay(
      timeSlot.timeOfDay,
      alwaysUse24HourFormat: true,
    );

    return OutlineButton(
      borderSide: BorderSide(color: color, width: 2),
      child: Text('${timeDescription}', style: textStyle),
      onPressed:
          timeSlot.isBooked ? null : () => onTimeSlotPicked?.call(timeSlot),
    );
  }
}
