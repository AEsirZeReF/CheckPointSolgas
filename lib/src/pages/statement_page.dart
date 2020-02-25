import 'dart:async';

import 'package:checkpoint/src/utils/help.dart';
import 'package:flutter/material.dart';

//
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class Statement extends StatefulWidget {
  @override
  _StatementState createState() => _StatementState();
}

class _StatementState extends State<Statement> {
  double latitud;
  double longitud;
  bool acepto = false;
  bool enviar = true;
  String declaracion =
      'Una declaración jurada es una manifestación escrita o verbal cuya veracidad es asegurada mediante un juramento ante una autoridad judicial o administrativa. Esto hace que el contenido de la declaración sea tomado como cierto hasta que se demuestre lo contrario.La institución de la declaración jurada ha sido establecida por diversos sistemas jurídicos, tanto de Common law como del Derecho continental, en gran parte para dar rapidez a ciertos trámites legales, sustituyendo transitoriamente a la presentación de documentos escritos o testimonios de terceros, mediante una presunción iuris tantum (que admite prueba en contrario).La importancia de la declaración jurada se halla en el hecho que permite abreviar procedimientos tanto ante autoridades judiciales como administrativas, y al mismo tiempo genera una responsabilidad legal para el declarante en caso que la declaración jurada resulte ser contraria a la verdad de los hechos que se acrediten posteriormente, equiparando la declaración jurada con un efectivo juramento o promesa de decir la verdad. Este último elemento puede tener consecuencias a nivel penal en los ordenamientos jurídicos que consideran al perjurio (o violación de juramento) como un delito, o en los países que imponen castigos penales o administrativos para quien formula cualquier declaración falsa ante ciertas autoridades.';
  bool alert = true;

  var height;
  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: help.tituloImagen,
          backgroundColor: help.blue,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: help.botonera(context, () {
          if (enviar == true && acepto == true) {
            Navigator.pushNamed(context, '/geozona',
                arguments: <String, Map<String, dynamic>>{
                  'statement': {
                    'state': true,
                    'latitud': latitud,
                    'longitud': longitud
                  },
                  'geozona': {'state': false},
                  'scanner': {
                    'state': false,
                    'unidad': null,
                    'conductor': null
                  },
                  'gallery': {
                    'state': false,
                    'img1': null,
                    'img2': null,
                    'img3': null,
                    'img4': null,
                    'img5': null
                  }
                });
          }
        }, color: Color(0xFF4e619b), texto: 'Confirmar'),
        body: help.layoutFondo(
            context,
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: Text(
                          'Declaración Jurada',
                          style: GoogleFonts.roboto(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      height: height < 600
                          ? MediaQuery.of(context).size.height * 0.30
                          : MediaQuery.of(context).size.height * 0.43,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          declaracion,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Checkbox(
                          onChanged: (val) {
                            setState(() {
                              acepto = val;
                            });
                          },
                          value: acepto,
                        ),
                        Text('Acepta todos los terminos y condiciones',
                            style:
                                TextStyle(color: Colors.white, fontSize: 13)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Checkbox(
                          onChanged: (val) {
                            setState(() {
                              enviar = val;
                            });
                          },
                          value: enviar,
                        ),
                        Text('Se enviara toda la información',
                            style:
                                TextStyle(color: Colors.white, fontSize: 13)),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future _getLocation() async {
    Position getPosition = new Position();
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    getPosition = await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .catchError((e) {
      print(e);
    });
    setState(() {
      latitud = getPosition.latitude;
      longitud = getPosition.longitude;
    });
  }
}
