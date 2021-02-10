import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/repair_shop.dart';
import '../service/appointment_builder.dart';
import '../service/order_provider.dart';
import '../service/date_time_provider.dart';
import 'datetime_picker_page.dart';
import 'order_list_page.dart';
import 'package:repairme/model/date_time_utility.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<Step> _steps = [];
  int _currentStep = 0;
  final Map<int, StepState> _stepState = {
    0: StepState.indexed,
    1: StepState.indexed,
    2: StepState.indexed,
  };

  @override
  void initState() {
    super.initState();

    _updateStepState();
  }

  @override
  Widget build(BuildContext context) {
    _steps = [
      Step(
          isActive: _currentStep == 0,
          state: _stepState[0],
          title: Text('Orders'),
          content: OrderListPage()),
      Step(
        isActive: _currentStep == 1,
        state: _stepState[1],
        title: Text('Date'),
        content: DateTimePickerPage(onDateTimePicked: _onStepContinue),
      ),
      Step(
        isActive: _currentStep == 2,
        state: _stepState[2],
        title: Text('Repair Shop'),
        content: Center(
          child: Text('Shop selector'),
        ),
      )
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('New Appointment')),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
        onStepTapped: _onStepTapped,
        steps: _steps,
      ),
    );
  }

  void _onStepContinue() {
    final builder = context.read<AppointmentBuilder>();

    switch (_currentStep) {
      case 0:
        builder.setOrders(context.read<OrderProvider>().orders);
        break;
      case 1:
        final dateTimeProvider = context.read<DateTimeProvider>();
        DateTime date;
        if (dateTimeProvider.selectedTimeSlot != null) {
          date = dateTimeProvider.selectedDate
              .withTimeOfDay(dateTimeProvider.selectedTimeSlot.timeOfDay);
        }
        builder.selectDate(date);
        break;
      case 2:
        builder.selectRepairShop(RepairShop());
        break;
    }
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep += 1;
        _updateStepState();
      });
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
        _updateStepState();
      });
    }
  }

  void _onStepTapped(int stepValue) {
    setState(() {
      _currentStep = stepValue;
      _updateStepState();
    });
  }

  void _updateStepState() {
    final builder = context.read<AppointmentBuilder>();

    final isStepStateValid = {
      0: builder.hasValidOrders,
      1: builder.hasValidDate,
      2: builder.hasValidRepairShop
    };
    _stepState.keys.forEach((step) {
      if (_stepState[step] == StepState.editing) {
        _stepState[step] =
            isStepStateValid[step] ? StepState.complete : StepState.error;
      }
    });
    _stepState[_currentStep] = StepState.editing;
  }
}
