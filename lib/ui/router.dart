import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otakuzon/ui/views/anime/anime_home.dart';
import 'package:otakuzon/ui/views/download/downloads.dart';
import 'package:otakuzon/ui/views/home/notification.dart';
import 'package:otakuzon/ui/views/manga/manga_home.dart';
import 'package:otakuzon/ui/views/settings.dart';
import '../core/constants/app_constants.dart';
import 'views/home/apphome.dart';
import 'views/mainscreen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    debugPrint(settings.name);
    switch (settings.name) {
      case RoutePaths.HomeTab:
        return _getPageRoute(
            view: AppHome(),
            routeName: settings.name,
            args: settings.arguments);
      case RoutePaths.HomeScreen:
        return _getPageRoute(
            view: const AppHomeScreen(),
            routeName: settings.name,
            args: settings.arguments);
      case RoutePaths.AnimeHome:
        return _getPageRoute(
            view: const AnimeHomeScreen(),
            routeName: settings.name,
            args: settings.arguments);
      case RoutePaths.MangaHome:
        return _getPageRoute(
            view: const MangaHomeScreen(),
            routeName: settings.name,
            args: settings.arguments);
      case RoutePaths.Settings:
        return _getPageRoute(
            view: const SettingsScreen(),
            routeName: settings.name,
            args: settings.arguments);
      case RoutePaths.Downloads:
        return _getPageRoute(
            view: const DownloadsScreen(),
            routeName: settings.name,
            args: settings.arguments);
      case RoutePaths.Notifications:
        return _getPageRoute(
            view: const NotificationScreen(),
            routeName: settings.name,
            args: settings.arguments);
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

PageRoute<dynamic> _getPageRoute({String routeName, Widget view, Object args}) {
  return CupertinoPageRoute<dynamic>(
      settings: RouteSettings(name: routeName, arguments: args),
      builder: (_) => view);
}
