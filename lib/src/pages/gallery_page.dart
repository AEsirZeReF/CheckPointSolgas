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
  int indexcam;

  Map<String, List<dynamic>> _configuracion = {
    'titulo': [
      'Foto 1: Selfie del conductor',
      'Foto 2: Extintor',
      'Foto 3: LLantas posteriores',
      'Foto 4: LLantas delanteras',
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
    'foto': [null, null, null, null, null]
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
          //control: new SwiperControl(),
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
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
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
          /*shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(50)),*/
          onPressed: () {
            getImage(indexcam);
          },
          child: Icon(
            Icons.camera_alt,
            size: 30,
          ),
        ),
      ),
    );
  }

  Future getImage(int i) async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      switch (i) {
        case 0:
          _configuracion['foto'][0] = image;
          args['gallery']['img1'] = image;
          _validacionFotosCompletas();
          print(args);

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

  /*Future _save(var image) async {
    List<int> lista = new List<int>();
    await image.writeAsBytes(lista);
    final result = await ImageGallerySaver.saveImage(Uint8List.fromList(lista));
    print(result);
  }*/

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
        builder: (context) => AlertDialog(
              title: Text('Usted a completado la captura de fotos'),
              content: Text('Seleccione una opción'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancelar',
                        style: GoogleFonts.roboto(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/game', arguments: args);
                  },
                  child: Text('Continuar',
                      style: GoogleFonts.roboto(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ],
            ));
  }

  /*List<Widget> _contentRow() {
    List<Widget> lista = new List<Widget>();
    for (var i = 0; i < 5; i++) {
      lista.add(_contentCard(i));
    }
    return lista;
  }*/

  _contentCard(int i) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            color: Colors.white,
            child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/images/BeanEater.gif'),
                image: _configuracion['foto'][i] == null
                    ? AssetImage(_configuracion['imagen'][i])
                    : FileImage(_configuracion['foto'][i])),
          ),
        ),
        /*Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    size: 200,
                  ),
                  onPressed: () {}),
            ),*/
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            color: Colors.black54,
            child: ListTile(
              /*contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 10),*/
              title: Text(_configuracion['titulo'][i],
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 30)),
              /*trailing: GestureDetector(
                onTap: () {
                  getImage(i);
                  setState(() {
                    _configuracion['animacionImagen'][i] = true;
                    _animacionAuto(i);
                  });
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 45,
                ),
              ),*/
            ),
          ),
        )
      ],
    );
  }

  /*_animacionAuto(int index) {
    for (var i = 0; i < _configuracion['animacionImagen'].length; i++) {
      if (index != i) {
        _configuracion['animacionImagen'][i] = false;
      }
    }
  }*/
}
