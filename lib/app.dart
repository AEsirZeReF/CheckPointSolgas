import 'dart:async';

import 'package:checkpoint/src/pages/gallery_page.dart';
import 'package:checkpoint/src/pages/geozona_page.dart';
import 'package:checkpoint/src/pages/game_page.dart';
import 'package:checkpoint/src/pages/load_page.dart';
import 'package:checkpoint/src/pages/scanner_page.dart';
import 'package:checkpoint/src/pages/statement_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
//import 'package:flutter_phoenix/flutter_phoenix.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  int time = 0;
  Timer timer;

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
        //print('app resumed');
        try {
          if (time > 180) {
            Phoenix.rebirth(context);
            timer.cancel();
          } else {
            timer.cancel();
            setState(() => time = 0);
          }
        } catch (e) {}
        break;
      case AppLifecycleState.inactive:
        startTimer();
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
        // print('$time');
      });
    });
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
        '/game': (context) => GamePage()
      },
    );
  }
}
