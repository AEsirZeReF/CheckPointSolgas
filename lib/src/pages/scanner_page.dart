import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:checkpoint/src/utils/help.dart';


class ScannerPage extends StatefulWidget {
  //Scanner({Key key}) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String barcode = '';
  
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
            Text('Escanear QR de conductor',style: help.estiloTexto,),
            SizedBox(height: 10,),
            RaisedButton(
              child: Text('Escanear QR'),
              
              onPressed: (){
                _scan();
              },
            ),
            SizedBox(height: 50,),
            Text('Escanear QR de unidad',style: help.estiloTexto,),
            SizedBox(height: 10,),
            RaisedButton(
              child: Text('Escanear QR'),
              onPressed: (){
                _scan();
              },
            ),
            Text('$barcode',style: help.estiloTexto,),
        ],
    );
  }
  Future _scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'El usuario no acepto el uso de la camara!';
        });
      } else {
        setState(() => this.barcode = 'Error Desconocido: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (El usuario utilizo el boton regresar)');
    } catch (e) {
      setState(() => this.barcode = 'Error Desconocido: $e');
    }
  }
  
}