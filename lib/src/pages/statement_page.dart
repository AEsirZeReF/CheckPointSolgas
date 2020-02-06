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
  @override
  void initState() {
    super.initState();
    _getLocation();
  }

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  'Declaración Jurada',
                  style: help.subtitle,
                ),
              ),
              SizedBox(
                height: help.contentSize(context)['heigth'] < 700 ? 10 : 50.0,
              ),
              Container(
                  width: 320,
                  height: help.contentSize(context)['heigth'] < 700 ? 300 : 350,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Text(
                        'Al contrario del pensamiento popular, el texto de Lorem Ipsum no es simplemente texto aleatorio. Tiene sus raices en una pieza cl´sica de la literatura del Latin, que data del año 45 antes de Cristo, haciendo que este adquiera mas de 2000 años de antiguedad. Richard McClintock, un profesor de Latin de la Universidad de Hampden-Sydney en Virginia, encontró una de las palabras más oscuras de la lengua del latín, "consecteur", en un pasaje de Lorem Ipsum, y al seguir leyendo distintos textos del latín, descubrió la fuente indudable. Lorem Ipsum viene de las secciones 1.10.32 y 1.10.33 de "de Finnibus Bonorum et Malorum" (Los Extremos del Bien y El Mal) por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum, "Lorem ipsum dolor sit amet..", viene de una linea en la sección 1.10.32',
                        style: help.parrafo,
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        'Al contrario del pensamiento popular, el texto de Lorem Ipsum no es simplemente texto aleatorio. Tiene sus raices en una pieza cl´sica de la literatura del Latin, que data del año 45 antes de Cristo, haciendo que este adquiera mas de 2000 años de antiguedad. Richard McClintock, un profesor de Latin de la Universidad de Hampden-Sydney en Virginia, encontró una de las palabras más oscuras de la lengua del latín, "consecteur", en un pasaje de Lorem Ipsum, y al seguir leyendo distintos textos del latín, descubrió la fuente indudable. Lorem Ipsum viene de las secciones 1.10.32 y 1.10.33 de "de Finnibus Bonorum et Malorum" (Los Extremos del Bien y El Mal) por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum, "Lorem ipsum dolor sit amet..", viene de una linea en la sección 1.10.32',
                        style: help.parrafo,
                        textAlign: TextAlign.justify,
                      )
                    ],
                  )),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FlatButton.icon(
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/geozona',
                arguments: <String, double>{
                  'latitud': latitud,
                  'longitud': longitud
                });
          },
          icon: Icon(
            Icons.check,
            color: help.blue,
          ),
          label: Text(
            'Siguiente',
            style: TextStyle(color: help.blue, fontSize: 16),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: BorderSide(width: 1.5, color: Colors.deepOrange)),
        ));
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
