import 'dart:async';
import 'package:checkpoint/src/utils/help.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
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
      'Solgas S.A. informa que sus datos personales han sido proporcionados por su empleador o la empresa que lo contrató,quien manifestó conocer y cumplir con la Ley N° 29733, Ley de Protección de Datos Personales, su Reglamento, aprobado por Decreto Supremo N° 003-2013-JUS, y todas las demás normas referidas a protección de datos personales. En ese sentido, declaró contar con su respectivo consentimiento.';
  bool alert = true;
  var height;
  @override
  void initState() {
    super.initState();
    _checkConnection();
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
                  'geozona': {'state': false, 'name': null},
                  'status': {'estado': null},
                  'scanner': {'unidad': null, 'conductor': null},
                  'type': {'tipooperacion': null},
                  'gallery': {
                    'state': false,
                    'img1': null,
                    'img2': null,
                    'img3': null,
                    'img4': null,
                    'img5': null,
                    'img6': null,
                    'img7': null,
                    'img8': null,
                    'img9': null,
                    'img10': null,
                    'img11': null,
                    'img12': null,
                  },
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                declaracion,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10)),
                              Text(
                                'Por medio de la presente, acepto y declaro que:',
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5)),
                              Text(
                                '1)	Me comprometo a usar el presente aplicativo.',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2)),
                              Text(
                                '2)	Conozco que la información recabada mediante el aplicativo será de uso exclusivo de Solgas S.A. y, por tanto, no debe ser compartida con ningún tercero.',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2)),
                              Text(
                                '3)	Usaré el aplicativo únicamente para los servicios contratados por Solgas.',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2)),
                              Text(
                                '4)	El uso del aplicativo es estrictamente personal.',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5)),
                              Text(
                                'Tengo pleno entendimiento de lo que aquí acepto y declaro; por lo tanto, doy mi conformidad.',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Colors.white,
                          ),
                          child: Checkbox(
                            checkColor: Colors.white,
                            activeColor: Colors.blue[500],
                            value: acepto,
                            onChanged: (bool val) {
                              setState(() {
                                acepto = val;
                              });
                            },
                          ),
                        ),
                        Text('Acepta todos los terminos y condiciones',
                            style:
                                TextStyle(color: Colors.white, fontSize: 13)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Colors.white,
                          ),
                          child: Checkbox(
                            checkColor: Colors.white,
                            activeColor: Colors.blue[500],
                            value: enviar,
                            onChanged: (bool val) {
                              setState(() {
                                enviar = val;
                              });
                            },
                          ),
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

  _checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      //print('I am connected to a mobile network.');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      //print('I am connected to a wifi network.');
    } else {
      //print('NO esta conectado a internet');
      _messageNoInternet();
    }
  }

  _messageNoInternet() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                titlePadding: EdgeInsets.all(0),
                title: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        topRight: Radius.circular(2)),
                    child: Image.asset(
                      'assets/images/lost.jpg',
                      fit: BoxFit.cover,
                      height: 250,
                    ),
                  ),
                ),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'No esta conectado a internet',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                        color: Color(0xFF2cb3a9),
                        onPressed: () {
                          Phoenix.rebirth(context);
                        },
                        child: Text('REINTENTAR',
                            style: GoogleFonts.roboto(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)))
                  ],
                ),
              ),
            ));
  }
}
