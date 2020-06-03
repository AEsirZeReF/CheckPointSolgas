import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:checkpoint/src/utils/help.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

class ScannerPage extends StatefulWidget {
  //Scanner({Key key}) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String _conductor;
  String _unidad;
  var args;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments
        as Map<String, Map<String, dynamic>>;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: help.tituloImagen,
          backgroundColor: help.blue,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: help.blue,
        body: help.layoutFondo(
            context,
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _conductor == null
                        ? _card(
                            titulo: 'QR de Conductor',
                            subtitulo:
                                'Escanear el codigo QR de su carnet a una distancia adecuada.',
                            qrmode: 'conductor')
                        : FutureBuilder(
                            initialData: false,
                            future: _getConductor(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  http.Response response = snapshot.data;
                                  if (response.statusCode == 200) {
                                    var res = json.decode(response.body);
                                    return Card(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(
                                              Icons.supervised_user_circle,
                                              color: Colors.blue,
                                            ),
                                            title: Text(
                                              'Información del conductor',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.blueAccent),
                                            ),
                                          ),
                                          Divider(),
                                          /*ListTile(
                                            leading: Container(
                                              width: 120,
                                              height: 120,
                                              child: CircleAvatar(
                                                  child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                clipBehavior: Clip.antiAlias,
                                                child: Image.asset(
                                                    'assets/images/face.jpg'),
                                              )),
                                            ),
                                            title: Text(
                                              '${res['firstname']} ${res['lastname']}',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 22),
                                            ),
                                          ),*/
                                          Text(
                                            '${res['firstname']}',
                                            style: GoogleFonts.roboto(
                                                fontSize: 22),
                                          ),
                                          Text(
                                            '${res['lastname']}',
                                            style: GoogleFonts.roboto(
                                                fontSize: 22),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20, top: 30),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text('DNI: ',
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black45)),
                                                Text(
                                                  '${res['dni']}',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 18),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                top: 5,
                                                bottom: 25),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'License Number: ',
                                                  style: GoogleFonts.roboto(
                                                      color: Colors.black45),
                                                ),
                                                Text(
                                                  '${res['license_number']}',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 18),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ));
                                  } else {
                                    return _card(
                                        titulo: 'QR de Conductor',
                                        subtitulo:
                                            'Escanear el codigo QR de su carnet a una distancia adecuada.',
                                        qrmode: 'conductor');
                                  }
                                }
                                if (snapshot.hasError)
                                  return CircularProgressIndicator();
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                    _unidad == null
                        ? _card(
                            titulo: 'QR de Unidad',
                            subtitulo:
                                'Escanear el codigo QR que se encuentra en la unidad.',
                            qrmode: 'unidad')
                        : FutureBuilder(
                            initialData: false,
                            future: _getUnidad(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  http.Response response = snapshot.data;
                                  if (response.statusCode == 200) {
                                    var res = json.decode(response.body);
                                    return Card(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(
                                              Icons.directions_car,
                                              color: Colors.blue,
                                            ),
                                            title: Text(
                                              'Información de la unidad',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.blueAccent),
                                            ),
                                          ),
                                          Divider(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 25),
                                            child: Text(
                                              'Placa:  ${res['license_plate']}',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 22),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  } else {
                                    return _card(
                                        titulo: 'QR de Unidad',
                                        subtitulo:
                                            'Escanear el codigo QR que se encuentra en la unidad.',
                                        qrmode: 'unidad');
                                  }
                                }
                                if (snapshot.hasError)
                                  return CircularProgressIndicator();
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                  ],
                ),
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _conductor != null && _unidad != null
            ? help.botonera(context, () {
                args['scanner']['conductor'] = _conductor;
                args['scanner']['unidad'] = _unidad;
                Navigator.pushNamed(context, '/channel', arguments: args);
              }, color: Color(0xFF4e619b))
            : Container(),
      ),
    );
  }

  Future _getConductor() async {
    try {
      return await http.get(
          'http://190.223.43.132:8000/control/web/api/get-driver/$_conductor');
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response> _getUnidad() async {
    try {
      return await http
          .get('http://190.223.43.132:8000/control/web/api/get-unit/$_unidad');
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future _scan({String qrmode}) async {
    switch (qrmode) {
      case 'conductor':
        try {
          String barcode = await BarcodeScanner.scan();
          setState(() {
            _conductor = barcode;
          });
        } on PlatformException catch (e) {
          if (e.code == BarcodeScanner.CameraAccessDenied) {
            this._conductor = null;
            print('El usuario no acepto el uso de la camara!');
          } else {
            _conductor = null;
            print('Error desconocido: $e');
          }
        } on FormatException {
          _conductor = null;
          print('El usuario utilizo el boton regresar');
        } catch (e) {
          _conductor = null;
          print('Error Desconocido: $e');
        }
        break;
      case 'unidad':
        try {
          String barcode = await BarcodeScanner.scan();
          //print(barcode);
          setState(() {
            _unidad = barcode;
          });
        } on PlatformException catch (e) {
          if (e.code == BarcodeScanner.CameraAccessDenied) {
            this._unidad = null;
            print('El usuario no acepto el uso de la camara!');
          } else {
            this._unidad = null;
            print('Error desconocido: $e');
          }
        } on FormatException {
          this._unidad = null;
          print('El usuario utilizo el boton regresar');
        } catch (e) {
          this._unidad = null;
          print('Error Desconocido: $e');
        }
    }
  }

  Widget _card({String titulo, String subtitulo, String qrmode}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Text(
                titulo,
                style: GoogleFonts.roboto(
                  fontSize: 24,
                ),
              ),
              subtitle: Text(
                subtitulo,
                style: GoogleFonts.roboto(fontSize: 20),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[_botonscanner(qrmode: qrmode)],
            )
          ],
        ),
      ),
    );
  }

  Widget _botonscanner({String qrmode}) {
    return FlatButton.icon(
      padding: EdgeInsets.only(top: 7, left: 28, bottom: 7, right: 28),
      color: Colors.deepOrange,
      onPressed: () {
        _scan(qrmode: qrmode);
        //print(args);
      },
      icon: Icon(
        Icons.camera_alt,
        color: help.white,
        size: 34,
      ),
      label: Text(
        'Escanear QR',
        style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

class FetchDataException implements Exception {
  final _message;
  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
