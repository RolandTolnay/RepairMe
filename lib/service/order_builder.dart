import 'package:flutter/material.dart';

import '../model/component.dart';
import '../model/order.dart';

abstract class OrderBuilder {
  GlobalKey<FormState> get newOrderFormKey;

  TextEditingController get componentNameController;
  TextEditingController get componentPriceController;
  TextEditingController get amountController;

  String validateComponentName(String componentName);
  String validateComponentPrice(String componentPrice);
  String validateAmount(String amount);

  Order makeOrder();
}

class RMOrderBuilder implements OrderBuilder {
  @override
  final amountController = TextEditingController();
  @override
  final componentNameController = TextEditingController();
  @override
  final componentPriceController = TextEditingController();

  @override
  final newOrderFormKey = GlobalKey<FormState>();

  @override
  Order makeOrder() {
    if (newOrderFormKey.currentState.validate()) {
      final component = Component(
        name: componentNameController.text.trim(),
        price: int.parse(componentPriceController.text.trim()),
      );
      return Order(
        amount: int.parse(amountController.text.trim()),
        component: component,
      );
    } else {
      return null;
    }
  }

  @override
  String validateAmount(String amount) {
    if (amount.trim().isEmpty) return 'Amount cannot be empty';
    final amountValue = int.tryParse(amount);
    if (amountValue == null) return 'Invalid amount';
    if (amountValue < 1) return 'Amount has to be greater than 0';
    return null;
  }

  @override
  String validateComponentName(String componentName) {
    if (componentName.trim().isEmpty) return 'Component name cannot be empty';
    return null;
  }

  @override
  String validateComponentPrice(String componentPrice) {
    if (componentPrice.trim().isEmpty) return 'Component price cannot be empty';
    final priceValue = int.tryParse(componentPrice);
    if (priceValue == null) return 'Invalid price';
    if (priceValue < 1) return 'Price has to be greater than 0';
    return null;
  }
}
