import 'package:flutter/material.dart';
import 'package:checkpoint/src/utils/help.dart';
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
      '1ra Foto: Extintor',
      '2da Foto: LLantas posteriores',
      '3ra Foto: LLantas delanteras',
      '4ta Foto: Cabina del conductor',
      '5ta Foto: Motor',
    ],
    'imagen': [
      'assets/images/img1.jpg',
      'assets/images/posterior.jpg',
      'assets/images/delanteras.jpg',
      'assets/images/cabina.jpg',
      'assets/images/motor.jpg'
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

  /*Future _save() async {
    List<int> lista = new List<int>();
    await _image.writeAsBytes(lista);
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
      print(args['gallery']);
    }
  }

  _messagePhotosComplete() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text('Captura de fotos completas'),
              content: Text('Continue'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/game', arguments: args);
                  },
                  child: Text('Continuar'),
                )
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
          child: ListBody(
        children: <Widget>[
          ListTile(
            title: Text(
              _configuracion['titulo'][i],
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.lightBlue),
            ),
            trailing: DropdownButton(
                value: drop,
                elevation: 12,
                iconEnabledColor: Colors.lightBlue,
                items: <String>['Eliminar', 'Editar'].map((value) {
                  return DropdownMenuItem(
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    value: value,
                  );
                }).toList(),
                onChanged: (newvalue) {
                  print('$newvalue');
                  setState(() {
                    if (newvalue == 'Eliminar')
                      _configuracion['foto'][i] = null;
                    drop = newvalue;
                  });
                }),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _configuracion['animacionImagen'][i] =
                    !_configuracion['animacionImagen'][i];
              });
            },
            child: AnimatedContainer(
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
          ListTile(
              title: Text(
                'Tomar la foto a una buena distancia',
                style: TextStyle(color: Colors.lightBlue),
              ),
              subtitle: Text('Precionar la imagen par expandirla.'),
              trailing: GestureDetector(
                onTap: () {
                  getImage(i);
                },
                child: Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: Colors.lightBlue,
                ),
              ))
        ],
      )),
      xs: 12,
    );
  }
}
