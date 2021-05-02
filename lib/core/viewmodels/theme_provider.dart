import 'package:flutter/foundation.dart';

class DarkThemeProvider with ChangeNotifier {
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    debugPrint('Dark them saved: $_darkTheme');
    notifyListeners();
  }
}
