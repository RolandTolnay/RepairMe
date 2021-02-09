import 'package:flutter/material.dart';

import 'service/services.dart';
import 'ui/order_list_page.dart';

void main() {
  setupProviders();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RepairMe',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OrderListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
