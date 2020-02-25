import 'package:checkpoint/src/pages/gallery_page.dart';
import 'package:checkpoint/src/pages/geozona_page.dart';
import 'package:checkpoint/src/pages/game_page.dart';
import 'package:checkpoint/src/pages/list_page.dart';
import 'package:checkpoint/src/pages/load_page.dart';
import 'package:checkpoint/src/pages/scanner_page.dart';
import 'package:checkpoint/src/pages/statement_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void main() {
    runApp(MaterialApp(
      home: LoadPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CheckPoint Virtual',
      initialRoute: '/', //Ruta inicial
      routes: {
        '/': (context) => LoadPage(),
        '/statement': (context) => Statement(),
        '/geozona': (context) => Geozona(),
        '/scanner': (content) => ScannerPage(),
        '/gallery': (context) => GalleryPage(),
        '/list': (context) => ListPage(),
        '/game': (context) => GamePage()
      },
    );
  }
}
