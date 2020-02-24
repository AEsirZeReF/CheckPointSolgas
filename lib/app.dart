//import 'package:checkpoint/src/game/game.dart';
import 'package:checkpoint/src/pages/gallery_page.dart';
import 'package:checkpoint/src/pages/geozona_page.dart';
import 'package:checkpoint/src/pages/game_page.dart';
//import 'package:checkpoint/src/pages/image_save.dart';
import 'package:checkpoint/src/pages/list_page.dart';
import 'package:checkpoint/src/pages/load_page.dart';
import 'package:checkpoint/src/pages/scanner_page.dart';
import 'package:checkpoint/src/pages/statement_page.dart';
//import 'package:checkpoint/src/utils/image_piker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
//import 'package:flutter/services.dart';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        //print('app paused');
        break;
      case AppLifecycleState.resumed:
        // Navigator.of(context).pushNamed('/');
        // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        //print('app resumed');
        break;
      case AppLifecycleState.inactive:
        //print('app inactive');
        break;
      case AppLifecycleState.detached:
        //print('app detached');
        break;
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
