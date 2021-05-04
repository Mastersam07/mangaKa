import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/services/navigator.dart';
import 'core/services/service.dart';
import 'core/viewmodels/navigation_viewmodel.dart';
import 'core/viewmodels/theme_provider.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  /// register services
  locator.registerLazySingleton<Service>(() => Service());
  locator.registerLazySingleton(() => NavigationService());

  /// register viewmodels
  // locator.registerFactory<NavigationViewModel>(() => NavigationViewModel());
}

// Register providers
final allProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
  ChangeNotifierProvider(create: (_) => NavigationViewModel()),
];
