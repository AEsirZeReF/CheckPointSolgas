import 'package:checkpoint/src/utils/help.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:android_intent/android_intent.dart';
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

  @override
  void initState() {
    super.initState();
    _checkGps();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, double>;

    if (args['latitud'] == null && args['longitud'] == null) {
      _latitud =
          getPosition.latitude == null ? -12.050867 : getPosition.latitude;
      _longitud =
          getPosition.longitude == null ? -77.029999 : getPosition.longitude;
    } else {
      _latitud = args['latitud'];
      _longitud = args['longitud'];
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
        body: help.layoutFondo(
          context,
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Center(
                        child: Text(
                      'CHECKPOINT VIRTUAL',
                      style: TextStyle(fontSize: 25, color: Colors.blue),
                    )),
                    subtitle: Center(
                        child: Text('Mi posición actual',
                            style: TextStyle(
                              fontSize: 16,
                            ))),
                  ),
                  Divider(
                    color: Colors.blue,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: _crearMapa(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/scanner');
            },
            color: Colors.white,
            child: Text(
              'Siguiente',
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(width: 2, color: Colors.lightBlue))),
      ),
    );
  }

  /* List<Widget> _crearListaContenido() {
    return <Widget>[
      Text(
        'CHECKPOINT VIRTUAL',
        style: help.subtitle,
      ),
      SizedBox(
        height: 15,
      ),
      Text(
        'GEOZONA',
        style: help.estiloTexto,
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        width: 380.0,
        height: 380.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: _crearMapa(),
        ),
      ),
      SizedBox(
        height: 40,
      )
    ];
  }*/

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
              title: Text("No se puede obtener la ubicación"),
              content: const Text('Por favor active su GPS'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
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
