import 'package:get_it/get_it.dart';

import 'appointment_builder.dart';
import 'order_builder.dart';
import 'order_provider.dart';

final service = GetIt.instance;

void setupProviders() {
  service.registerLazySingleton<OrderProvider>(() => RMOrderProvider());

  service.registerFactory<OrderBuilder>(() => RMOrderBuilder());
  service.registerFactory<AppointmentBuilder>(() => RMAppointmentBuilder());
}
