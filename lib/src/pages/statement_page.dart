import 'package:checkpoint/src/utils/help.dart';
import 'package:flutter/material.dart';

//
import 'package:geolocator/geolocator.dart';

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
  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: help.tituloImagen,
          backgroundColor: help.blue,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: help.layoutFondo(
            context,
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.085,
                  right: 20.0,
                  left: 20.0),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    ///<<<<<<<<<<<<<<<<<<convert to card
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Center(
                            child: Text(
                              'Declaración Jurada',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.80,
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              declaracion,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(right: 20.0, left: 20.0, top: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Checkbox(
                                  value: acepto,
                                  onChanged: (val) {
                                    setState(() {
                                      acepto = val;
                                    });
                                  }),
                              Text('Acepta todos los terminos y condiciones',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20.0, left: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                child: Checkbox(
                                    value: enviar,
                                    onChanged: (val) {
                                      setState(() {
                                        enviar = val;
                                      });
                                    }),
                              ),
                              Text(
                                'Se enviara toda la información',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(right: 20.0, left: 20.0, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  if (enviar == true && acepto == true) {
                                    Navigator.pushNamed(context, '/geozona',
                                        arguments: <String, double>{
                                          'latitud': latitud,
                                          'longitud': longitud
                                        });
                                  }
                                },
                                child: Text('Confirmar'),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(
                                        width: 2, color: Colors.blue)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
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
