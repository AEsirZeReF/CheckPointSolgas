import 'package:checkpoint/src/utils/help.dart';
import 'package:flutter/material.dart';

class ScannerPage extends StatefulWidget {
  //Scanner({Key key}) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: help.tituloImagen,
        backgroundColor: help.blue,
        centerTitle: true,
      ),
      backgroundColor: help.blue,
      body: Center(
        child: _cargarColumna(),
      ),
    );
  }
  Widget _cargarColumna(){
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
            Text('CHECKPOINT VIRTUAL', style: help.subtitle,),
            SizedBox(height: 50,),
            Text('Escanear QR de conductor')
        ],
    );
  }
}