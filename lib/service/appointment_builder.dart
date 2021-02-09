import 'package:flutter/material.dart';

import '../model/appointment.dart';
import '../model/order.dart';
import '../model/repair_shop.dart';

abstract class AppointmentBuilder extends ChangeNotifier {
  bool get hasValidOrders;
  bool get hasValidDate;
  bool get hasValidRepairShop;

  void setOrders(List<Order> orders);
  void selectDate(DateTime date);
  void selectRepairShop(RepairShop repairShop);

  Appointment makeAppointment();
}

class RMAppointmentBuilder extends ChangeNotifier
    implements AppointmentBuilder {
  List<Order> _orders = <Order>[];
  DateTime _date;
  RepairShop _repairShop;

  @override
  bool get hasValidDate => _date != null;
  @override
  bool get hasValidOrders => _orders.isNotEmpty;
  @override
  bool get hasValidRepairShop => _repairShop != null;

  @override
  void setOrders(List<Order> orders) {
    _orders = orders;
    notifyListeners();
  }

  @override
  void selectDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  @override
  void selectRepairShop(RepairShop repairShop) {
    _repairShop = repairShop;
    notifyListeners();
  }

  @override
  Appointment makeAppointment() {
    return Appointment(
      orders: _orders,
      date: _date,
      repairShop: _repairShop,
    );
  }
}
