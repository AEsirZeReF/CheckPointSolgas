import 'package:checkpoint/src/pages/image2.dart';
import 'package:flutter/material.dart';

class ImageExample extends StatefulWidget {
  ImageExample({Key key}) : super(key: key);

  @override
  _ImageExampleState createState() => _ImageExampleState();
}

class _ImageExampleState extends State<ImageExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Titulo'),
        ),
        body: GestureDetector(
          onTap: () => Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  pageBuilder: (_, __, ___) => ImageExample2())),
          child: Hero(
            tag: "DemoTag",
            child: Container(
              child: Icon(
                Icons.add,
                size: 70.0,
              ),
            ),
          ),
        ));
  }
}
