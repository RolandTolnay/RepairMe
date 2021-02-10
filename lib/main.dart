import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'service/appointment_builder.dart';
import 'service/date_time_provider.dart';
import 'service/order_provider.dart';
import 'service/repair_shop_provider.dart';
import 'service/services.dart';
import 'ui/root_page.dart';

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
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => service<AppointmentBuilder>()),
          ChangeNotifierProvider(create: (_) => service<OrderProvider>()),
          ChangeNotifierProvider(create: (_) => service<DateTimeProvider>()),
          ChangeNotifierProvider(create: (_) => service<RepairShopProvider>()),
        ],
        child: RootPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
