import 'dart:collection';

import 'package:flutter/material.dart';

import '../model/order.dart';

abstract class OrderProvider extends ChangeNotifier {
  UnmodifiableListView<Order> get orders;

  void addOrder(Order order);
}

class RMOrderProvider extends ChangeNotifier implements OrderProvider {
  final _orders = <Order>[];

  @override
  UnmodifiableListView<Order> get orders => UnmodifiableListView(_orders);

  @override
  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }
}
