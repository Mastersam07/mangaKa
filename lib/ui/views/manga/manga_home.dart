import 'package:flutter/material.dart';

class MangaHomeScreen extends StatelessWidget {
  const MangaHomeScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Manga Home',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
