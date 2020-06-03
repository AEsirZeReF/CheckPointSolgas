import 'package:flutter/material.dart';
import 'package:checkpoint/src/utils/help.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class GalleryEnvasadoPage extends StatefulWidget {
  GalleryEnvasadoPage({Key key}) : super(key: key);

  @override
  _GalleryEnvasadoPageState createState() => _GalleryEnvasadoPageState();
}

class _GalleryEnvasadoPageState extends State<GalleryEnvasadoPage> {
  //animacion de contenedor
  String drop = 'Eliminar';
  var args;
  int indexcam = 0;
  bool zoom = false;
  Map<String, List<dynamic>> _configuracionLlantas = {
    'titulo': [
      'Tomar foto Llantas',
    ],
    'imagen': [
      'assets/images/ga3.jpg',
      'assets/images/ga4.jpg',
      'assets/images/ga3.jpg',
      'assets/images/ga4.jpg',
    ],
    'foto': [
      null,
      null,
      null,
      null,
    ],
    'zoom': [
      true,
      true,
      true,
      true,
    ]
  };
  Map<String, List<dynamic>> _configuracion = {
    'titulo': [
      'Selfie del conductor',
      'Extintor',
      'Todas las llantas',
      'Toma frontal de la unidad',
      'Toma posterior de la unidad',
      'Luces delanteras',
      'Luces posteriores',
      'Estado de plataforma',
      'Eslingas colocadas',
    ],
    'imagen': [
      'assets/images/ga1.png',
      'assets/images/ga2.png',
      'assets/images/ga1.png',
      'assets/images/frontalcamion.jpg',
      'assets/images/posteriorcamion.jpg',
      'assets/images/frontalluces.jpg',
      'assets/images/posteriorluces.jpg',
      'assets/images/baseplataforma.jpg',
      'assets/images/eslingas.jpg',
    ],
    'foto': [
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
    ],
    'zoom': [
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
    ]
  };

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments
        as Map<String, Map<String, dynamic>>;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: help.tituloImagen,
          centerTitle: true,
          backgroundColor: help.blue,
          automaticallyImplyLeading: false,
        ),
        //backgroundColor: help.blue,
        body: Swiper(
          itemCount: 9,
          layout: SwiperLayout.DEFAULT,
          scrollDirection: Axis.vertical,
          pagination: new SwiperPagination(),
          onIndexChanged: (val) {
            setState(() {
              indexcam = val;
            });
          },
          itemBuilder: (context, index) {
            return _contentCard(index);
          },
        ),
        bottomNavigationBar: BottomAppBar(
          //shape: CircularNotchedRectangle(),
          notchMargin: 10,
          elevation: 20,
          color: Color(0xFF0b2265),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.open_with,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      _configuracion['zoom'][indexcam] =
                          !_configuracion['zoom'][indexcam];
                    });
                  }),
              IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    _validacionFotosCompletas();
                  }),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF020d2f),
          tooltip: 'Capturar imagen',
          onPressed: () {
            getImage(indexcam);
          },
          child: Icon(
            Icons.camera_alt,
            size: 35,
          ),
        ),
      ),
    );
  }

  Future getImageLlantas(int i) async {
    var image =
        await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    setState(() {
      switch (i) {
        case 0:
          _configuracionLlantas['foto'][0] = image;
          args['gallery']['img3'] = image;
          _validacionFotosCompletas();
          break;
        case 1:
          _configuracionLlantas['foto'][1] = image;
          args['gallery']['img4'] = image;
          _validacionFotosCompletas();
          break;
        case 2:
          _configuracionLlantas['foto'][2] = image;
          args['gallery']['img5'] = image;
          _validacionFotosCompletas();
          break;
        case 3:
          _configuracionLlantas['foto'][3] = image;
          args['gallery']['img6'] = image;
          _validacionFotosCompletas();
          break;
      }
    });
  }

  Future getImage(int i) async {
    if (i == 2 &&
        _configuracionLlantas['foto'][0] != null &&
        _configuracionLlantas['foto'][1] != null &&
        _configuracionLlantas['foto'][2] != null &&
        _configuracionLlantas['foto'][3] != null) {
    } else {
      var image = await ImagePicker.pickImage(
          source: ImageSource.camera, maxHeight: 600);
      setState(() {
        switch (i) {
          case 0:
            _configuracion['foto'][0] = image;
            args['gallery']['img1'] = image;
            _validacionFotosCompletas();
            break;
          case 1:
            _configuracion['foto'][1] = image;
            args['gallery']['img2'] = image;
            _validacionFotosCompletas();
            break;
          case 2:
            if (_configuracionLlantas['foto'][0] == null &&
                _configuracionLlantas['foto'][1] == null &&
                _configuracionLlantas['foto'][2] == null &&
                _configuracionLlantas['foto'][3] == null) {
              _configuracionLlantas['foto'][0] = image;
              args['gallery']['img3'] = image;
              _validacionFotosCompletas();
            } else if (_configuracionLlantas['foto'][1] == null &&
                _configuracionLlantas['foto'][2] == null &&
                _configuracionLlantas['foto'][3] == null) {
              _configuracionLlantas['foto'][1] = image;
              args['gallery']['img4'] = image;
              _validacionFotosCompletas();
            } else if (_configuracionLlantas['foto'][2] == null &&
                _configuracionLlantas['foto'][3] == null) {
              _configuracionLlantas['foto'][2] = image;
              args['gallery']['img5'] = image;
              _validacionFotosCompletas();
            } else {
              _configuracionLlantas['foto'][3] = image;
              args['gallery']['img6'] = image;
              _validacionFotosCompletas();
            }
            break;
          case 3:
            _configuracion['foto'][3] = image;
            args['gallery']['img7'] = image;
            _validacionFotosCompletas();
            break;
          case 4:
            _configuracion['foto'][4] = image;
            args['gallery']['img8'] = image;
            _validacionFotosCompletas();
            break;
          case 5:
            _configuracion['foto'][5] = image;
            args['gallery']['img9'] = image;
            _validacionFotosCompletas();
            break;
          case 6:
            _configuracion['foto'][6] = image;
            args['gallery']['img10'] = image;
            _validacionFotosCompletas();
            break;
          case 7:
            _configuracion['foto'][7] = image;
            args['gallery']['img11'] = image;
            _validacionFotosCompletas();
            break;
          case 8:
            _configuracion['foto'][8] = image;
            args['gallery']['img12'] = image;
            _validacionFotosCompletas();
            break;
        }
      });
    }
  }

  void _validacionFotosCompletas() {
    if (args['gallery']['img1'] != null &&
        args['gallery']['img2'] != null &&
        args['gallery']['img3'] != null &&
        args['gallery']['img4'] != null &&
        args['gallery']['img5'] != null &&
        args['gallery']['img6'] != null &&
        args['gallery']['img7'] != null &&
        args['gallery']['img8'] != null &&
        args['gallery']['img9'] != null &&
        args['gallery']['img10'] != null &&
        args['gallery']['img11'] != null &&
        args['gallery']['img12'] != null) {
      args['gallery']['state'] = true;
      _messagePhotosComplete();
      args['gallery'].forEach((k, v) => print('$k  $v'));
    }
  }

  _messagePhotosComplete() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                /*title: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        topRight: Radius.circular(2)),
                    child: Image.asset(
                      'assets/images/completed.jpg',
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),*/
                contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                titlePadding: EdgeInsets.all(0),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Usted a completado la captura de fotos',
                      style: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text('Seleciones una opción'),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            color: Colors.lightBlue,
                            child: Text('CANCELAR',
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))),
                        RaisedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/game',
                                arguments: args);
                          },
                          color: Colors.lightGreen,
                          child: Text('CONTINUAR',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  _contentCard(int i) {
    if (i == 2) {
      return Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/cool.png',
                      ),
                      fit: BoxFit.cover)),
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.18),
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        getImageLlantas(0);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder:
                                AssetImage('assets/images/BeanEater.gif'),
                            image: _configuracionLlantas['foto'][0] == null
                                ? AssetImage(_configuracionLlantas['imagen'][0])
                                : FileImage(_configuracionLlantas['foto'][0])),
                        color: Colors.teal[100],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        getImageLlantas(1);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder:
                                AssetImage('assets/images/BeanEater.gif'),
                            image: _configuracionLlantas['foto'][1] == null
                                ? AssetImage(_configuracionLlantas['imagen'][1])
                                : FileImage(_configuracionLlantas['foto'][1])),
                        color: Colors.teal[200],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        getImageLlantas(2);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder:
                                AssetImage('assets/images/BeanEater.gif'),
                            image: _configuracionLlantas['foto'][2] == null
                                ? AssetImage(_configuracionLlantas['imagen'][2])
                                : FileImage(_configuracionLlantas['foto'][2])),
                        color: Colors.teal[300],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        getImageLlantas(3);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder:
                                AssetImage('assets/images/BeanEater.gif'),
                            image: _configuracionLlantas['foto'][3] == null
                                ? AssetImage(_configuracionLlantas['imagen'][3])
                                : FileImage(_configuracionLlantas['foto'][3])),
                        color: Colors.teal[400],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              color: Colors.black54,
              child: ListTile(
                  title: Text(_configuracion['titulo'][i],
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold))),
            ),
          ),
        ],
      );
    } else {
      return Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/cool.png',
                      ),
                      fit: BoxFit.cover)),
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              child: FadeInImage(
                  fit:
                      _configuracion['zoom'][i] ? BoxFit.contain : BoxFit.cover,
                  placeholder: AssetImage('assets/images/BeanEater.gif'),
                  image: _configuracion['foto'][i] == null
                      ? AssetImage(_configuracion['imagen'][i])
                      : FileImage(_configuracion['foto'][i])),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              color: Colors.black54,
              child: ListTile(
                  title: Text(_configuracion['titulo'][i],
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold))),
            ),
          )
        ],
      );
    }
  }
}
