import 'package:get_it/get_it.dart';

import 'appointment_builder.dart';
import 'date_time_provider.dart';
import 'order_builder.dart';
import 'order_provider.dart';
import 'repair_shop_provider.dart';

final service = GetIt.instance;

void setupProviders() {
  service.registerFactory<AppointmentBuilder>(() => RMAppointmentBuilder());
  service.registerFactory<OrderBuilder>(() => RMOrderBuilder());
  service.registerFactory<OrderProvider>(() => RMOrderProvider());
  service.registerFactory<DateTimeProvider>(() => RMDateTimeProvider());
  service.registerFactory<RepairShopProvider>(() => RMRepairShopProvider());
}
