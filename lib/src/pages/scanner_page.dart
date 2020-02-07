import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:checkpoint/src/utils/help.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive/responsive.dart';

class ScannerPage extends StatefulWidget {
  //Scanner({Key key}) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String _conductor;
  String _unidad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: help.tituloImagen,
        backgroundColor: help.blue,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: help.blue,
      body: Center(
        child: _cargarColumna(),
      ),
      floatingActionButton:
          help.botonSiguiente(context, '/gallery', 'Siguiente'),
      /* floatingActionButton:
          help.botonSiguiente(context, '/gallery', 'Siguiente'),*/
    );
  }

//Navigator.pushNamed(context, '/gallery');
  Widget _cargarColumna() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'CHECKPOINT VIRTUAL',
          style: help.subtitle,
        ),
        SizedBox(
          height: 20,
        ),
        Container(child: _condicional()),
        SizedBox(
          height: 40,
        )
      ],
    );
  }

  Widget _condicional() {
    if (_conductor == null && _unidad == null) {
      return _contenedor();
    } else {
      return _informacionConductor();
    }
  }

  Widget _informacionConductor() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _conductor == null
            ? _contentCard(
                titulo: 'QR de Conductor',
                subtitulo:
                    'Escanear el codigo QR de su carnet a una distancia adecuada.',
                qrmode: 'conductor')
            : _conductorCard(
                'Información del Conductor', 'Nombre: $_conductor'),
        _unidad == null
            ? _contentCard(
                titulo: 'QR de Unidad',
                subtitulo:
                    'Escanear el codigo QR de la Unidad a una distancia adecuada.',
                qrmode: 'unidad')
            : _conductorCard('Informacion de la Unidad', 'Codigo: $_unidad'),
        SizedBox(
          height: 50,
        ),
        help.botonSiguiente(context, '/gallery', 'Siguiente')
      ],
    );
  }

  Widget _contenedor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _contentCard(
            titulo: 'QR de Conductor',
            subtitulo:
                'Escanear el codigo QR de su carnet a una distancia adecuada.',
            qrmode: 'conductor'),
        _contentCard(
            titulo: 'QR de Unidad',
            subtitulo:
                'Escanear el codigo QR de la Unidad a una distancia adecuada.',
            qrmode: 'unidad'),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Future _scan({String qrmode}) async {
    switch (qrmode) {
      case 'conductor':
        try {
          String barcode = await BarcodeScanner.scan();
          setState(() => _conductor = barcode);
        } on PlatformException catch (e) {
          if (e.code == BarcodeScanner.CameraAccessDenied) {
            setState(() {
              this._conductor = null;
              print('El usuario no acepto el uso de la camara!');
            });
          } else {
            setState(() => _conductor = null);
            print('Error desconocido: $e');
          }
        } on FormatException {
          setState(() => _conductor = null);
          print('El usuario utilizo el boton regresar');
        } catch (e) {
          setState(() => _conductor = null);
          print('Error Desconocido: $e');
        }
        break;
      case 'unidad':
        try {
          String barcode = await BarcodeScanner.scan();
          setState(() => _unidad = barcode);
        } on PlatformException catch (e) {
          if (e.code == BarcodeScanner.CameraAccessDenied) {
            setState(() {
              this._unidad = null;
              print('El usuario no acepto el uso de la camara!');
            });
          } else {
            setState(() => this._unidad = null);
            print('Error desconocido: $e');
          }
        } on FormatException {
          setState(() => this._unidad = null);
          print('El usuario utilizo el boton regresar');
        } catch (e) {
          setState(() => this._unidad = null);
          print('Error Desconocido: $e');
        }
        break;
    }
  }

  Widget _contentCard({String titulo, String subtitulo, String qrmode}) {
    return ResponsiveRow(
      crossAxisAlignment: WrapCrossAlignment.center,
      columnsCount: 12,
      children: <Widget>[
        FlexWidget(
          child: _card(titulo: titulo, subtitulo: subtitulo, qrmode: qrmode),
          xs: 10,
        )
      ],
    );
  }

  Widget _card({String titulo, String subtitulo, String qrmode}) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            subtitle: Text(subtitulo),
            title: Text(
              titulo,
              style: GoogleFonts.lato(fontSize: 18),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: <Widget>[_botonscanner(qrmode: qrmode)],
          )
        ],
      ),
    );
  }

  Widget _botonscanner({String qrmode}) {
    return FlatButton.icon(
      padding: EdgeInsets.only(top: 7, left: 30, bottom: 7, right: 30),
      color: Colors.deepOrange,
      onPressed: () {
        _scan(qrmode: qrmode);
      },
      icon: Icon(
        Icons.camera_alt,
        color: help.white,
      ),
      label: Text(
        'Escanear QR',
        style: help.parrafo,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  Widget _conductorCard(String titulo, String nombre) {
    return ResponsiveRow(
      crossAxisAlignment: WrapCrossAlignment.center,
      columnsCount: 12,
      children: <Widget>[
        FlexWidget(
          child: Card(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  title: Text(titulo),
                  subtitle: Text(nombre),
                )
              ],
            ),
          ),
          xs: 10,
        )
      ],
    );
  }
}
