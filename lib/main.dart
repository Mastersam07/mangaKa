import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:komikkurida/views/manga_list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'mangaX',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColorBrightness: Brightness.light,
        platform: TargetPlatform.iOS,
      ),
      home: MangaScreen(),
    );
  }
}
