import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'core/viewmodels/theme_provider.dart';
import 'locator.dart';
import 'ui/shared/app_theme.dart';
import 'ui/router.dart' as router;
import 'ui/splashscreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv.load(fileName: '.env');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme = themeChangeProvider.darkTheme;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: allProviders,
      child: Consumer<DarkThemeProvider>(
        builder: (context, appState, child) {
          return MaterialApp(
            title: 'MangaX',
            debugShowCheckedModeBanner: false,
            theme:
                appState.darkTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: appState.darkTheme ? ThemeMode.dark : ThemeMode.light,
            home: const Splash(),
            onGenerateRoute: router.Router.generateRoute,
          );
          // );
        },
      ),
    );
  }
}
