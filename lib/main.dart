import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:komikkurida/models/data.dart';
import 'package:komikkurida/views/detail.dart';
//import 'package:komikkurida/views/home.dart';
import 'package:komikkurida/views/manga_list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'GeekLib',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColorBrightness: Brightness.light,
        platform: TargetPlatform.iOS,
      ),
      home: MangaScreen(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }

  ///Generate parameterized route --> e.g: detail/some book title
  generateRoute(RouteSettings settings) {
    final path = settings.name.split('/');
    final title = path[1];

    Book book = books.firstWhere((it) => it.title == title);
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => Detail(book),
    );
  }
}
