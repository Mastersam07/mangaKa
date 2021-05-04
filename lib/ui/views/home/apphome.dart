import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/services/navigator.dart';
import '../../../core/viewmodels/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';

class AppHomeScreen extends StatelessWidget {
  const AppHomeScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Otakuzon',
          style: Theme.of(context).textTheme.button,
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.lightbulb),
              onPressed: () {
                themeChange.setDarkTheme = !themeChange.darkTheme;
              }),
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                locator<NavigationService>()
                    .navigateTo(RoutePaths.Notifications);
              })
        ],
      ),
      body: Center(
        child: Text(
          'App Home',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
