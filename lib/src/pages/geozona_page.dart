//import 'dart:io';
import 'dart:convert';

import 'package:checkpoint/src/utils/help.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong/latlong.dart';
import 'package:android_intent/android_intent.dart';
import 'package:http/http.dart' as http;
//import 'package:dio/dio.dart';
//
//import 'package:geolocator/geolocator.dart';

//
class Geozona extends StatefulWidget {
  Geozona({Key key}) : super(key: key);

  @override
  _GeozonaState createState() => _GeozonaState();
}

class _GeozonaState extends State<Geozona> {
  Position getPosition = new Position();
  MapController map = new MapController();
  double _latitud;
  double _longitud;
  bool _visible = false;
  var args;
  @override
  void initState() {
    super.initState();
    _checkGps();
    _getLocation();
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _visible = !_visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments
        as Map<String, Map<String, dynamic>>;

    if (args['statement']['latitud'] == null &&
        args['statement']['longitud'] == null) {
      _latitud =
          getPosition.latitude == null ? -12.050867 : getPosition.latitude;
      _longitud =
          getPosition.longitude == null ? -77.029999 : getPosition.longitude;
    } else {
      _latitud = args['statement']['latitud'];
      _longitud = args['statement']['longitud'];
      setState(() {
        args['geozona']['state'] = true;
      });
    }
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
          body: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  child: _crearMapa(),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 50,
                        child: FloatingActionButton(
                          backgroundColor: Color(0xFF2e4792),
                          onPressed: () {
                            if (getPosition.latitude != null &&
                                getPosition.longitude != null)
                              map.move(
                                  LatLng(getPosition.latitude,
                                      getPosition.longitude),
                                  17);
                          },
                          child: Icon(Icons.gps_fixed),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: _visible ? 1.0 : 0.0,
            child: RaisedButton(
                onPressed: () async {
                  var resformat;
                  try {
                    var res = await http.get(
                        'http://checkpoint.segursat.com:8080/control/web/api/check-if-the-driver-is-inside-the-control-zone/${getPosition.latitude}/${getPosition.longitude}/');
                    print('  ');
                    print(res.body);
                    resformat = json.decode(res.body);
                    print('->>> format ${resformat['status']}');

                    if (res.statusCode == 200) {
                      if (resformat['status'] == false) {
                        _checkNOValido(
                            text: "Estas fuera del punto de control",
                            image: 'perdido.png');
                        print("estas fuera de la geozona");
                      } else {
                        setState(() {
                          args['geozona']['name'] =
                              resformat['checkpoint']['name'];
                        });
                        _checkValido(resformat['checkpoint']['name']);
                      }
                    } else {
                      _checkNOValido(
                          text: "Hubo un problema con la conexión al servidor");
                    }
                  } catch (e) {
                    print('->> fallo de conexion: $e');
                    _checkNOValido();
                  }
                },
                color: help.blue,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  child: Text(
                    'CHECKPOINT',
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  /*side: BorderSide(width: 2, color: Colors.lightBlue)*/
                )),
          )),
    );
  }

  _checkValido(String text) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2),
                          topRight: Radius.circular(2)),
                      child: Image.asset('assets/images/validado.jpg')),
                ),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'POSICIÓN CORRECTAMENTE VALIDADA',
                      style: GoogleFonts.openSans(
                          fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      text,
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                        color: Colors.lightGreen,
                        child: Text(
                          'Continuar',
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/status',
                              arguments: args);
                        })
                  ],
                ),
              ),
            ));
  }

  _checkNOValido(
      {String text = "Hubo un problema con la conexión a internet",
      String image = "lost.jpg"}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => WillPopScope(
              onWillPop: () async => true,
              child: AlertDialog(
                title: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2),
                          topRight: Radius.circular(2)),
                      child: Image.asset('assets/images/$image')),
                ),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height) *
                          0.02,
                      child: Text(
                        text,
                        style: GoogleFonts.openSans(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    RaisedButton(
                        color: Colors.lightGreen,
                        child: Text(
                          'REINTENTAR',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ),
            ));
  }

  Widget _crearMapa() {
    return FlutterMap(
      mapController: map,
      options: MapOptions(
          center: LatLng(_latitud, _longitud), //posicion del mapa
          zoom: 15.0,
          maxZoom: 17.0,
          minZoom: 10.0),
      layers: [
        _cargarTemplate(),
        _crearMarcadores(),
        //_crearGeozonas(),
        //_crearPoligonos()
      ],
    );
  }

  TileLayerOptions _cargarTemplate() {
    return TileLayerOptions(
      urlTemplate:
          'https://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}&s=Ga',
      subdomains: ['a', 'b', 'c'],
    );
  }

  MarkerLayerOptions _crearMarcadores() {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          width: 100.0,
          height: 100.0,
          point: LatLng(_latitud, _longitud),
          builder: (context) {
            return Container(
              child: Icon(
                Icons.location_on,
                size: 50,
                color: Colors.blue,
              ),
            );
          }),
    ]);
  }

  _getLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      //
      setState(() {
        getPosition = position;
        map.move(LatLng(getPosition.latitude, getPosition.longitude), 17);
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Necesitamos su localización actual",
                style: GoogleFonts.roboto(fontSize: 20),
              ),
              content: Text('Por favor active su GPS'),
              actions: <Widget>[
                FlatButton(
                  child: Text('ACTIVAR',
                      style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    final AndroidIntent intent = AndroidIntent(
                        action: 'android.settings.LOCATION_SOURCE_SETTINGS');

                    intent.launch();
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
  /*_crearGeozonas() {
    return CircleLayerOptions(circles: [
      CircleMarker(
          point: LatLng(_latitud, _longitud),
          radius: 50.0,
          color: Color.fromRGBO(0, 0, 0, 0.2),
          borderColor: Colors.black12,
          borderStrokeWidth: 5.0),
    ]);
  }*/

  /*_crearPoligonos() {
    return PolygonLayerOptions(polygons: <Polygon>[
      new Polygon(points: <LatLng>[
        LatLng(37.421015, -122.085488),
        LatLng(37.422412, -122.085069),
        LatLng(37.422161, -122.083438),
        LatLng(37.421164, -122.082140)
      ], color: Color.fromRGBO(0, 0, 0, 0.0), borderStrokeWidth: 2)
    ]);
  }*/
}
