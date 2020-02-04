import 'package:flutter/material.dart';
import 'package:checkpoint/src/utils/help.dart';
import 'package:image_picker/image_picker.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<String> _cadenaImagenes = new List(5);
  var _picture;
  //List<dynamic> _listaImagenes = new List<dynamic>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: help.tituloImagen,
        centerTitle: true,
        backgroundColor: help.blue,
      ),
      backgroundColor: help.blue,
      body: _picture == null ? _noImagen() : _listaImagenes(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FlatButton(
        color: Colors.white,
        onPressed: () {
          _mensajeSeleccionImagen(context);
        },
        child: Text(
          'Seleccionar Imagen',
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }

  _capturarImagem(BuildContext context) async {
    _picture = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() => _cadenaImagenes.add(_picture.path));
    Navigator.of(context).pop();
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
                    child: Text('Camara'),
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
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _cadenaImagenes.length,
      itemBuilder: (BuildContext context, int index) {
        String url = _cadenaImagenes[index];
        return FadeInImage(
            placeholder: AssetImage('assets/images/Ripple.gif'),
            image: AssetImage(url));
      },
    );
  }

  Widget _noImagen() {
    return Container(
      child: Image.network(
          'https://i.pinimg.com/originals/90/80/60/9080607321ab98fa3e70dd24b2513a20.gif'),
    );
  }

  /*List<dynamic> listaImages() {
    for (var item in _cadenaImagenes) {
      setState(() {
        var child = Image.asset(item);
        _listaImagenes.add(child);
      });
    }
    return _listaImagenes;
  }*/
}
