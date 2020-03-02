import 'package:flutter/material.dart';
import 'package:checkpoint/src/utils/help.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  //animacion de contenedor
  String drop = 'Eliminar';
  var args;
  int indexcam = 0;
  bool zoom = false;

  Map<String, List<dynamic>> _configuracion = {
    'titulo': [
      'Foto 1: Selfie del conductor',
      'Foto 2: Extintor',
      'Foto 3: Llantas posteriores',
      'Foto 4: Llantas delanteras',
      'Foto 5: Selfie delante del carro',
    ],
    'imagen': [
      'assets/images/selfi.jpg',
      'assets/images/extintor.jpg',
      'assets/images/posterior.jpg',
      'assets/images/delanteras.jpg',
      'assets/images/selficar.jpg'
    ],
    'icon': [
      Icons.looks_one,
      Icons.looks_two,
      Icons.looks_3,
      Icons.looks_4,
      Icons.looks_5
    ],
    'animacionImagen': [false, false, false, false, false],
    'foto': [null, null, null, null, null],
    'zoom': [false, false, false, false, false]
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
          itemCount: 5,
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
                    if (_configuracion['foto'][0] != null &&
                        _configuracion['foto'][1] != null &&
                        _configuracion['foto'][2] != null &&
                        _configuracion['foto'][3] != null &&
                        _configuracion['foto'][4] != null) {
                      _messagePhotosComplete();
                      args['gallery']['state'] = true;
                    }
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

  Future getImage(int i) async {
    var image =
        await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 1200);
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
          _configuracion['foto'][2] = image;
          args['gallery']['img3'] = image;
          _validacionFotosCompletas();
          break;
        case 3:
          _configuracion['foto'][3] = image;
          args['gallery']['img4'] = image;
          _validacionFotosCompletas();
          break;
        case 4:
          _configuracion['foto'][4] = image;
          args['gallery']['img5'] = image;
          _validacionFotosCompletas();
          break;
      }
    });
  }

  void _validacionFotosCompletas() {
    if (_configuracion['foto'][0] != null &&
        _configuracion['foto'][1] != null &&
        _configuracion['foto'][2] != null &&
        _configuracion['foto'][3] != null &&
        _configuracion['foto'][4] != null) {
      _messagePhotosComplete();
      args['gallery']['state'] = true;
    }
  }

  _messagePhotosComplete() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Container(
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
                ),
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
                fit: _configuracion['zoom'][i] ? BoxFit.contain : BoxFit.cover,
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
