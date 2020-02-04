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
  String barcode;

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
      floatingActionButton: FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, '/gallery');
          },
          color: help.white,
          child: Text(
            'Siguiente',
            style: TextStyle(color: help.blue),
          )),
    );
  }

  Widget _cargarColumna() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'CHECKPOINT VIRTUAL',
          style: help.subtitle,
        ),
        Container(
            height: 600,
            child: barcode == null
                ? _contenedorBotonScan()
                : _informacionConductor())
      ],
    );
  }

  Widget _informacionConductor() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Informacion del conductor',
          style: help.subtitle,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          '$barcode',
          style: help.estiloTexto,
        ),
        SizedBox(
          height: 50,
        ),
        FlatButton(
          color: help.white,
          onPressed: () {
            Navigator.pushNamed(context, '/gallery');
          },
          child: Text(
            'Continuar',
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }

  Widget _contenedorBotonScan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Escanear QR de Conductor',
          style: help.estiloTexto,
        ),
        SizedBox(
          height: 10,
        ),
        RaisedButton(
          child: Text('Escanear QR'),
          onPressed: () {
            _scan();
          },
        ),
        SizedBox(
          height: 50,
        ),
        Text(
          'Escanear QR de unidad',
          style: help.estiloTexto,
        ),
        SizedBox(
          height: 10,
        ),
        RaisedButton(
          child: Text('Escanear QR'),
          onPressed: () {
            _scan();
          },
        ),
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
          this.barcode = null;
          print('El usuario no acepto el uso de la camara!');
        });
      } else {
        setState(() => this.barcode = null);
        print('Error desconocido: $e');
      }
    } on FormatException {
      setState(() => this.barcode = null);
      print('El usuario utilizo el boton regresar');
    } catch (e) {
      setState(() => this.barcode = null);
      print('Error Desconocido: $e');
    }
  }
}
