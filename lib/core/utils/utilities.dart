import 'dart:io';

import 'package:intl/intl.dart';

class Utilities {
  static const String customErrorMessage =
      'An error occurred. Please try again';

  static File convertedString;

  static final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');

  static String dateFormatter(String date) {
    final formatter = DateFormat('yyyy-MM-dd');
    final dateTime = formatter.parse(date);
    final formatted = formatter.format(dateTime);
    print('formated date: $formatted----');
    final reformatDate = formatted.split('-');
    final formattedDate =
        reformatDate[2] + '-' + reformatDate[1] + '-' + reformatDate[0];

    print(formattedDate);
    return formattedDate;
  }

  static String yearMonthDay(String date) {
    final reformatDate = date.split('-');
    final formattedDate =
        reformatDate[2] + '-' + reformatDate[1] + '-' + reformatDate[0];
    print('date sent to server: $formattedDate');
    return formattedDate;
  }

  ///convert datetime format to Month, Day and Year
  static String dateToYmd(String date) {
    final formatter = DateFormat('yyyy-MM-dd');
    final dateTime = formatter.parse(date);
    final formattedDateTime = DateFormat.yMMMd().format(dateTime);

    return formattedDateTime;
  }

  ///convert datetime format to Month, Day and Year
  static String dayDateAndTime(DateTime date) {
    /*var formatter = new DateFormat('yyyy-MM-dd');
    DateTime dateTime = formatter.parse(date);
    //var formattedDateTime = DateFormat.yMMMd().format(dateTime);*/

    final dateFormat = DateFormat.EEEE();
    return '''
${dateFormat.format(date)}, ${DateFormat.MMMd().format(date)}, ${DateFormat.j().format(date)}''';
  }

  ///convert datetime format to day and date
  static String dayAndDate(DateTime date) {
    return '''
${DateFormat.EEEE().format(date)}, ${DateFormat.yMMMMd().format(date)}''';
  }

  ///convert datetime to weekday
  static String abbreviateWeekDay(DateTime date) {
    return DateFormat.E().format(date);
  }

  ///convert date time to day
  static String day(DateTime date) {
    return DateFormat.d().format(date);
  }

  ///convert date time to month
  static String abbreviateMonth(DateTime date) {
    return DateFormat.MMM().format(date);
  }

  ///convert datetime format to Month, Day and Year
  static String dateAndTime(DateTime date) {
    return '''
${DateFormat.yMMMd().format(date)} ${DateFormat.jms().format(date)}''';
  }

  ///format currency
  static String formatAmount(double amount) {
    final oCcy = NumberFormat('#,##0.00', 'en_US');
    final formattedAmount = oCcy.format(amount);
    return formattedAmount;
  }
}
