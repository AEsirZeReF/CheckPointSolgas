//import 'dart:io';

import 'package:checkpoint/src/utils/help.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong/latlong.dart';
import 'package:android_intent/android_intent.dart';
//import 'package:dio/dio.dart';
//
//import 'package:geolocator/geolocator.dart';

//
class Geozona extends StatefulWidget {
  Geozona({Key key}) : super(key: key);

  @override
  _GeozonaState createState() => _GeozonaState();
}

class _GeozonaState extends State<Geozona> with WidgetsBindingObserver {
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        //print('app paused');
        break;
      case AppLifecycleState.resumed:
        // Navigator.of(context).pushNamed('/');
        // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        //print('app resumed');
        break;
      case AppLifecycleState.inactive:
        //print('app inactive');
        break;
      case AppLifecycleState.detached:
        //print('app detached');
        break;
    }
  }

  //>>>>>>>>>>>>>
  Position getPosition = new Position();
  MapController map = new MapController();
  double _latitud;
  double _longitud;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkGps();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: help.botonera(context, () {
          Navigator.pushNamed(context, '/scanner', arguments: args);
        }, color: help.blue),
      ),
    );
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
        _crearPoligonos()
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

  _crearPoligonos() {
    return PolygonLayerOptions(polygons: <Polygon>[
      new Polygon(points: <LatLng>[
        LatLng(37.421015, -122.085488),
        LatLng(37.422412, -122.085069),
        LatLng(37.422161, -122.083438),
        LatLng(37.421164, -122.082140)
      ], color: Color.fromRGBO(0, 0, 0, 0.0), borderStrokeWidth: 2)
    ]);
  }
}
