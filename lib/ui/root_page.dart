import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/repair_shop.dart';
import '../service/appointment_builder.dart';
import '../service/order_provider.dart';
import '../service/services.dart';
import 'order_list_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final builder = context.watch<AppointmentBuilder>();

    final steps = [
      Step(
          isActive: _currentStep == 0,
          state:
              builder.hasValidOrders ? StepState.complete : StepState.editing,
          title: Text('Orders'),
          content: ChangeNotifierProvider.value(
            value: service<OrderProvider>(),
            child: OrderListPage(),
          )),
      Step(
        isActive: _currentStep == 1,
        title: Text('Date'),
        content: Center(
          child: Text('Date selector'),
        ),
      ),
      Step(
        isActive: _currentStep == 2,
        title: Text('Repair Shop'),
        content: Center(
          child: Text('Shop selector'),
        ),
      )
    ];

    return Scaffold(
      appBar: AppBar(title: Text('New Appointment')),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () => onStepContinue(steps.length),
        onStepCancel: onStepCancel,
        onStepTapped: onStepTapped,
        steps: steps,
      ),
    );
  }

  void onStepContinue(int stepCount) {
    final builder = context.read<AppointmentBuilder>();

    switch (_currentStep) {
      case 0:
        // TODO: Think about this
        builder.setOrders(service<OrderProvider>().orders);
        break;
      case 1:
        builder.selectDate(DateTime.now());
        break;
      case 2:
        builder.selectRepairShop(RepairShop());
        break;
    }
    if (_currentStep < stepCount - 1) {
      setState(() {
        _currentStep += 1;
      });
    }
  }

  void onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  void onStepTapped(int stepValue) {
    setState(() {
      _currentStep = stepValue;
    });
  }
}
