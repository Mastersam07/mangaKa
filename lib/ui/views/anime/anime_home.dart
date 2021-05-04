import 'package:flutter/material.dart';

class AnimeHomeScreen extends StatelessWidget {
  const AnimeHomeScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Anime Home',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
