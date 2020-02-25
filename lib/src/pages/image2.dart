import 'package:flutter/material.dart';

class ImageExample2 extends StatefulWidget {
  ImageExample2({Key key}) : super(key: key);

  @override
  _ImageExample2State createState() => _ImageExample2State();
}

class _ImageExample2State extends State<ImageExample2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Demo tag'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Hero(
              tag: "DemoTag",
              child: Container(
                color: Colors.blue,
                child: Icon(
                  Icons.add,
                  size: 150.0,
                ),
              ),
            ),
          ],
        ));
  }
}
