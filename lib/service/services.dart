import 'package:get_it/get_it.dart';
import 'package:repairme/service/order_provider.dart';

import 'order_builder.dart';

final service = GetIt.instance;

void setupProviders() {
  service.registerFactory<OrderBuilder>(() => RMOrderBuilder());
  service.registerLazySingleton<OrderProvider>(() => RMOrderProvider());
}
