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
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  http.Response res = snapshot.data;
                                  var response = json.decode(res.body);
                                  print(response['dni']);
                                  return Card(
                                    child: ListBody(
                                      children: <Widget>[
                                        ListTile(
                                          title:
                                              Text('Información del conductor'),
                                        ),
                                        ListBody(
                                          children: <Widget>[
                                            Text(
                                              'Nombre: ${response['firstname']}',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              'Apellido: ${response['lastname']}',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              'DNI: ${response['dni']}',
                                              style: TextStyle(fontSize: 20),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
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
                                'Escanear el codigo QR de su carnet a una distancia adecuada.',
                            qrmode: 'unidad')
                        : FutureBuilder(
                            initialData: false,
                            future: _getConductor(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  http.Response res = snapshot.data;
                                  var response = json.decode(res.body);
                                  print(response['dni']);
                                  return Card(
                                    child: ListBody(
                                      children: <Widget>[
                                        ListTile(
                                          title:
                                              Text('Información del conductor'),
                                        ),
                                        ListBody(
                                          children: <Widget>[
                                            Text(
                                              'Nombre: ${response['firstname']}',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              'Apellido: ${response['lastname']}',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              'DNI: ${response['dni']}',
                                              style: TextStyle(fontSize: 20),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
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
        floatingActionButton: help.botonera(context, () {
          Navigator.pushNamed(context, '/gallery', arguments: args);
        }, color: Color(0xFF4e619b)),
      ),
    );
  }

  Future<http.Response> _getConductor() async {
    http.Response res = await http.get(
        'http://190.223.43.132:8000/control/web/api/get-driver/$_conductor');
    switch (res.statusCode) {
      case 200:
        return res;
      case 400:
        throw BadRequestException(res.body.toString());
      case 403:
        throw UnauthorisedException(res.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${res.statusCode}');
    }
  }

  /*Future<http.Response> _getUnidad() async {
    try {
      http.Response res =
          await http.get('https://apirex.herokuapp.com/api/oneuser/$_unidad');
      switch (res.statusCode) {
        case 200:
          return res;
        case 400:
          throw BadRequestException(res.body.toString());
          break;
        case 403:
          throw UnauthorisedException(res.body.toString());
          break;
        default:
          throw FetchDataException(
              'Error occured while Communication with Server with StatusCode : ${res.statusCode}');
          break;
      }
    } catch (e) {
      return null;
    }
  }*/

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
    }
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
}

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}
