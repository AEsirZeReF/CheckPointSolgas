import 'package:flutter/material.dart';
import 'package:checkpoint/src/utils/help.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive/responsive.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  //animacion de contenedor
  String drop = 'Eliminar';
  var args;

  Map<String, List<dynamic>> _configuracion = {
    'titulo': [
      'Foto: Selfie del conductor',
      'Foto: Extintor',
      'Foto: LLantas posteriores',
      'Foto: LLantas delanteras',
      'Foto: Selfie delante del carro',
    ],
    'imagen': [
      'assets/images/selfi.jpg',
      'assets/images/img1.jpg',
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
        backgroundColor: help.blue,
        body: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            scrollDirection: Axis.vertical,
            children: <Widget>[_contentRow()],
          ),
        ),
      ),
    );
  }

  Future getImage(int i) async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 600, maxHeight: 1000);
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
                    child: Text('Cancelar')),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/game', arguments: args);
                  },
                  child: Text('Continuar'),
                ),
              ],
            ));
  }

  ResponsiveRow _contentRow() {
    List<Widget> lista = new List<Widget>();
    for (var i = 0; i < 5; i++) {
      lista.add(_contentCard(i));
    }
    return ResponsiveRow(
      columnsCount: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: lista,
    );
  }

  FlexWidget _contentCard(int i) {
    return FlexWidget(
      child: Card(
          child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              _configuracion['titulo'][i],
              style: GoogleFonts.roboto(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            subtitle: Text('Tomar la foto a una buena distancia'),
            leading: Icon(
              _configuracion['icon'][i],
              color: Colors.blue,
              size: 28,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _configuracion['animacionImagen'][i] =
                    !_configuracion['animacionImagen'][i];
              });
            },
            child: AnimatedContainer(
              width: MediaQuery.of(context).size.width,
              duration: Duration(milliseconds: 700),
              height: _configuracion['animacionImagen'][i] ? 300 : 150,
              curve: Curves.fastOutSlowIn,
              color: Colors.white,
              child: FadeInImage(
                  fit: BoxFit.cover,
                  height: _configuracion['animacionImagen'][i] ? 300 : 150,
                  placeholder: AssetImage('assets/images/BeanEater.gif'),
                  image: _configuracion['foto'][i] == null
                      ? AssetImage(_configuracion['imagen'][i])
                      : FileImage(_configuracion['foto'][i])),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 6,
                ),
                Expanded(child: Container()),
                FlatButton(
                  child: Text('Eliminar',
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    setState(() {
                      _configuracion['foto'][i] = null;
                    });
                  },
                ),
                FlatButton(
                  child: Text(
                    'Capturar',
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue),
                  ),
                  onPressed: () {
                    setState(() {
                      getImage(i);
                      _configuracion['animacionImagen'][i] = true;
                      _animacionAuto(i);
                    });
                  },
                ),
              ],
            ),
          )
        ],
      )),
      xs: 12,
    );
  }

  _animacionAuto(int index) {
    for (var i = 0; i < _configuracion['animacionImagen'].length; i++) {
      if (index != i) {
        _configuracion['animacionImagen'][i] = false;
      }
    }
  }
}
