import 'package:checkpoint/src/utils/help.dart';
import 'package:flutter/material.dart';
class Search extends StatelessWidget {
  //const name({Key key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: help.imageSolGas(42.0),
        backgroundColor: help.blue,

      ),
      backgroundColor: help.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('CHECKPOINT VIRTUAL',style: help.subtitle,),
            SizedBox(height: 150.0,),
            Text('Buscando Geocerca',style: help.estiloTexto,),
            SizedBox(height: 30.0,),
            Icon(Icons.gps_fixed,color: help.white,size: 250.0,)
          ],
        ),
      ),
    );
  }
}