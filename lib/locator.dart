import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/services/service.dart';
import 'core/viewmodels/theme_provider.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  /// register services
  locator.registerLazySingleton<Service>(() => Service());

  /// register viewmodels
  // locator.registerFactory<LoginModel>(() => LoginModel());
}

// Register providers
final allProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
];
