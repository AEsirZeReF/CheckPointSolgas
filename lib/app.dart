import 'package:checkpoint/src/pages/geozona_page.dart';
import 'package:checkpoint/src/pages/load_page.dart';
import 'package:checkpoint/src/pages/scanner_page.dart';
import 'package:checkpoint/src/pages/statement_page.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //home:new  Home (),
      //home: new Load(),
      //home: new Search(),
      //home: new Geozona(),
      initialRoute: '/',//Ruta inicial
      routes: {
        '/'           : (context) => LoadPage(),
        '/statement'  :(context) => Statement(),
        '/geozona'    :(context) => Geozona(),
        '/scanner'    :(content) => ScannerPage()
      },
    );
  }
}