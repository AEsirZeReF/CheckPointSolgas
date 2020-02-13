import 'package:checkpoint/src/utils/help.dart';
import 'package:flutter/material.dart';

class LoadPage extends StatefulWidget {
  LoadPage({Key key}) : super(key: key);

  @override
  _LoadPageState createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/statement');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: help.blue,
      body: Center(
        child: help.layoutFondo(
            context,
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: MediaQuery.of(context).size.width,
                child: Image.asset('assets/images/logo.png'),
              ),
            )),
      ),
    );
  } //
}
