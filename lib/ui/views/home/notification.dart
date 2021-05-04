import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final String payload;
  const NotificationScreen({Key key, this.payload}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    debugPrint('Notification: $payload');
    return Scaffold(
      body: Center(
        child: Text(
          'Notification Screen',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
