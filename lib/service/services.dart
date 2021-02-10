import 'package:get_it/get_it.dart';
import 'package:repairme/service/date_time_provider.dart';

import 'appointment_builder.dart';
import 'order_builder.dart';
import 'order_provider.dart';

final service = GetIt.instance;

void setupProviders() {
  service.registerFactory<AppointmentBuilder>(() => RMAppointmentBuilder());
  service.registerFactory<OrderBuilder>(() => RMOrderBuilder());
  service.registerFactory<OrderProvider>(() => RMOrderProvider());
  service.registerFactory<DateTimeProvider>(() => RMDateTimeProvider());
}
