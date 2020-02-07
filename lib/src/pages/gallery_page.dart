import 'package:flutter/material.dart';
import 'package:checkpoint/src/utils/help.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:responsive/responsive.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  //List<String> _cadenaImagenes = new List();

  File _file; //List<dynamic> _listaImagenes = new List<dynamic>();
  List<File> _listFile = new List();
  double size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: help.tituloImagen,
          centerTitle: true,
          backgroundColor: help.blue,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: help.blue,
        body: _file == null ? _noImagen() : _listaImagenes(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            _listFile.length == 5 ? _botonSiguiente() : _botonCaptura());
  }

  Widget _botonCaptura() {
    return FloatingActionButton(
      onPressed: () {
        _mensajeSeleccionImagen(context);
        //_capturarImagem(context);
      },
      child: Icon(Icons.camera_alt),
      tooltip: 'Tomar fotos',
    );
  }

  Widget _botonSiguiente() {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.check),
    );
  }

//_mensajeSeleccionImagen(context);
  _capturarImagem(BuildContext context) async {
    try {
      var _picture = await ImagePicker.pickImage(source: ImageSource.camera);

      setState(() {
        _file = _picture;
        if (_file != null) _listFile.add(_file);
      });
      Navigator.of(context).pop();
    } on PlatformException {
      print('Error');
    } catch (e) {
      print('El error es :$e');
    }
  }

  Future _mensajeSeleccionImagen(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Seleccione una opción:'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                  ),
                  GestureDetector(
                    child: Text(
                      'Camara',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      _capturarImagem(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _listaImagenes() {
    final orientation = MediaQuery.of(context).orientation;
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        itemCount: _listFile.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(4.5),
            child: Image.file(
              _listFile[index],
              fit: BoxFit.cover,
            ),
          ));
        });
  }

  Widget _noImagen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Capture 5 images',
            style: help.subtitle,
          ),
          SizedBox(
            height: 15,
          ),
          ResponsiveRow(
            columnsCount: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              FlexWidget(
                child: Container(
                  padding: EdgeInsets.only(bottom: 60.0),
                  child: Image.asset(
                    'assets/images/hand.png',
                  ),
                ),
                xs: 8,
                xsOffset: 1,
              )
            ],
          )
        ],
      ),
    );
  }
}
