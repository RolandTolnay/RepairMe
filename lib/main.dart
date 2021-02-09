import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'service/appointment_builder.dart';
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
      home: ChangeNotifierProvider(
        create: (_) => service<AppointmentBuilder>(),
        child: RootPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
