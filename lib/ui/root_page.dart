import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/appointment_builder.dart';
import 'datetime_picker_page.dart';
import 'order_list_page.dart';
import 'repair_shop_list_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
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
    final steps = [
      Step(
          isActive: _currentStep == 0,
          state: _stepState[0],
          title: const Text('Orders'),
          content: OrderListPage(onOrderListChanged: (orders) {
            context.read<AppointmentBuilder>().setOrders(orders);
          })),
      Step(
        isActive: _currentStep == 1,
        state: _stepState[1],
        title: const Text('Date'),
        content: DateTimePickerPage(onDateTimePicked: (dateTime) {
          context.read<AppointmentBuilder>().selectDate(dateTime);
        }),
      ),
      Step(
        isActive: _currentStep == 2,
        state: _stepState[2],
        title: const Text('Repair Shop'),
        content: RepairShopListPage(onRepairShopSelected: (repairShop) {
          context.read<AppointmentBuilder>().selectRepairShop(repairShop);
        }),
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
        steps: steps,
      ),
    );
  }

  void _onStepContinue() {
    if (_currentStep < _stepState.keys.length - 1) {
      setState(() {
        _currentStep += 1;
        _updateStepState();
      });
    } else {
      final completedStepper = _stepState.keys.every(_isStepCompleted);
      if (completedStepper) {
        final builder = context.read<AppointmentBuilder>();
        final appointment = builder.makeAppointment();
        print(appointment);
        showDialog(context: context, child: _buildStepperCompletedDialog());
      }
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
    _stepState.keys.forEach((step) {
      if (_stepState[step] == StepState.editing) {
        _stepState[step] =
            _isStepCompleted(step) ? StepState.complete : StepState.error;
      }
    });
    _stepState[_currentStep] = StepState.editing;
  }

  bool _isStepCompleted(int step) {
    final builder = context.read<AppointmentBuilder>();

    switch (step) {
      case 0:
        return builder.hasValidOrders;
      case 1:
        return builder.hasValidDate;
      case 2:
        return builder.hasValidRepairShop;
      default:
        return false;
    }
  }

  AlertDialog _buildStepperCompletedDialog() {
    return AlertDialog(
      title: const Text('Good job!'),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('THANKS'),
        )
      ],
    );
  }
}
