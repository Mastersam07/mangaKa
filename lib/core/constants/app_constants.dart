import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class RoutePaths {
  static const String Onboarding = '/';
  static const String HomeScreen = '/home';
  static const String HomeTab = '/homeTab';
  static const String AnimeHome = '/animeHome';
  static const String MangaHome = '/mangahome';
  static const String Downloads = '/downloads';
  static const String Settings = '/settings';
  static const String Notifications = '/notification';
}

// ignore: avoid_bool_literals_in_conditional_expressions
bool devMode = env['DEBUG'] == 'true' ? true : false;
const String username = 'username';
const String isremember = 'is_remember';
const String emptyEmailField = 'Email field cannot be empty!';
const String emptyTextField = 'Field cannot be empty!';
const String emptyPasswordField = 'Password field cannot be empty';
const String invalidEmailField =
    "Email provided isn\'t valid.Try another email address";
const String passwordLengthError = 'Password length must be greater than 6';
const String emptyUsernameField = 'Username  cannot be empty';
const String usernameLengthError = 'Username length must be greater than 6';
const String emailRegex = '[a-zA-Z0-9\+\.\_\%\-\+]{1,256}' +
    '\\@' +
    '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}' +
    '(' +
    '\\.' +
    '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}' +
    ')+';

const String phoneNumberRegex = r'0[789][01]\d{8}';

const String phoneNumberLengthError = 'Phone number must be 11 digits';

const String invalidPhoneNumberField =
    "Number provided isn\'t valid.Try another phone number";

//MediaQuery Width
double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

//MediaQuery Height
double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

String yearMonthDay(String date) {
  final reformatDate = date.split('-');
  final formattedDate =
      reformatDate[2] + '-' + reformatDate[1] + '-' + reformatDate[0];
  print('date sent to server: $formattedDate');
  return formattedDate;
}

//convert datetime format to Month, Day and Year
String dateAndTime(DateTime date) {
  return '${DateFormat.yMMMd().format(date)}';
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');
