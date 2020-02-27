import 'package:checkpoint/src/pages/gallery_page.dart';
import 'package:checkpoint/src/pages/geozona_page.dart';
import 'package:checkpoint/src/pages/game_page.dart';
import 'package:checkpoint/src/pages/list_page.dart';
import 'package:checkpoint/src/pages/load_page.dart';
import 'package:checkpoint/src/pages/scanner_page.dart';
import 'package:checkpoint/src/pages/statement_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print('resumed');
      Phoenix.rebirth(context);
    }
  }

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
