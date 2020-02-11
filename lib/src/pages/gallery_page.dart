//import 'dart:io';
//import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:checkpoint/src/utils/help.dart';
//import 'package:permission_handler/permission_handler.dart';
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
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/game');
        },
        child: Icon(
          Icons.arrow_right,
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
          break;
        case 1:
          _configuracion['foto'][1] = image;
          break;
        case 2:
          _configuracion['foto'][2] = image;
          break;
        case 3:
          _configuracion['foto'][3] = image;
          break;
        case 4:
          _configuracion['foto'][4] = image;
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

  /*void _validator(BuildContext context) {
    if (_configuracion['foto'][0] != null &&
        _configuracion['foto'][1] != null &&
        _configuracion['foto'][2] != null &&
        _configuracion['foto'][3] != null &&
        _configuracion['foto'][4] != null) {
      _mensajeSeleccionImagen(context);
    }
  }*/

  /*Future _mensajeSeleccionImagen(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Seleccione una opción'),
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
                    onTap: () {},
                  )
                ],
              ),
            ),
          );
        });
  }*/
}

/*import 'package:flutter/material.dart';
import 'package:checkpoint/src/utils/help.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:responsive/responsive.dart';
import 'package:path/path.dart' as path;
import 'package:path/path.dart';
import 'package:image_save/image_save.dart';
import 'dart:typed_data';
//import 'package:image/image.dart' as I;

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  String directory;
  String pathImagenes;
  //String _ruta;
  File picture;

  @override
  void initState() {
    super.initState();
    _direccion();
  }

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
      body: _noImagen(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      /*floatingActionButton:
            _listFile.length == 5 ? _botonSiguiente() : _botonCaptura()*/
    );
  }

  _capturarImagem() async {
    String ruta;
    try {
      var _picture = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        picture = _picture;
      });
      String rutaImagen = path.basename(_picture.path);
      //_picture.copy('$directory/$rutaImagen');
      List<int> listaimg = new List<int>();
      await _picture.writeAsBytes(listaimg);
      pathImagenes = join(directory, rutaImagen);
      ruta = await ImageSave.saveImage("jpg", Uint8List.fromList(listaimg));
      print(ruta);
    } on PlatformException {
      print('Error en la plataforma');
    } catch (e) {
      print('El error es :$e');
    }
  }

  void _direccion() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    setState(() {
      directory = documentsDirectory.path;
    });
  }

  Widget _noImagen() {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        ResponsiveRow(
          columnsCount: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            _cardGallery1(),
          ],
        )
      ],
    );
  }

  Widget _cardGallery1() {
    return FlexWidget(
      xs: 10,
      xsOffset: 1,
      child: Card(
        child: ListBody(
          children: <Widget>[
            ListTile(
                title: Text('1ra Foto: Extintor'),
                subtitle: Text('Tome la foto a una distancia prudente.'),
                trailing: GestureDetector(
                  child: Icon(
                    Icons.camera_alt,
                    size: 40,
                  ),
                  onTap: () {
                    _capturarImagem();
                  },
                )),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: picture == null ? Text('Cargando') : Image.file(picture))
          ],
        ),
      ),
    );
  }*/

/*Widget _cardGallery2() {
    return FlexWidget(
      xs: 10,
      xsOffset: 1,
      child: Card(
        child: ListBody(
          children: <Widget>[
            ListTile(
                title: Text('2da Foto: Llantas posteriores'),
                subtitle: Text('Tome la foto detalladamente.'),
                trailing: GestureDetector(
                  child: Icon(
                    Icons.camera_alt,
                    size: 40,
                  ),
                  onTap: () {
                    print('objectasss');
                  },
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  print('object');
                },
              ),
            )
          ],
        ),
      ),
    );
  }*/

/*Widget _cardGallery3() {
    return FlexWidget(
      xs: 10,
      xsOffset: 1,
      child: Card(
        child: ListBody(
          children: <Widget>[
            ListTile(
                title: Text('3ra Foto: Llantas delanteras'),
                subtitle: Text('Tome la foto detalladamente.'),
                trailing: GestureDetector(
                  child: Icon(
                    Icons.camera_alt,
                    size: 40,
                  ),
                  onTap: () {
                    print('objectasss');
                  },
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                child: Image.network(
                  'https://statics.memondo.com/p/99/crs/2017/10/CR_1054253_b49f715008494f1790ca39c3f2652d33_que_fue_antes_thumb_fb.jpg?cb=6914896',
                ),
                onTap: () {
                  print('object');
                },
              ),
            )
          ],
        ),
      ),
    );
  }*/

/*Widget _cardGallery4() {
    return FlexWidget(
      xs: 10,
      xsOffset: 1,
      child: Card(
        child: ListBody(
          children: <Widget>[
            ListTile(
                title: Text('4ta Foto: Cabina del Conductor'),
                subtitle: Text('Tome la foto detalladamente.'),
                trailing: GestureDetector(
                  child: Icon(
                    Icons.camera_alt,
                    size: 40,
                  ),
                  onTap: () {
                    print('objectasss');
                  },
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                child: Image.network(
                  'https://smart-lighting.es/wp-content/uploads/2017/04/17C183_03-640x360.jpg',
                ),
                onTap: () {
                  print('object');
                },
              ),
            )
          ],
        ),
      ),
    );
  }*/

/*Widget _botonCaptura() {
    return FloatingActionButton(
      onPressed: () {
        _mensajeSeleccionImagen(context);
        //_capturarImagem(context);
      },
      child: Icon(Icons.camera_alt),
      tooltip: 'Tomar fotos',
    );
  }*/

/*Widget _botonSiguiente() {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.check),
    );
  }*/

//_mensajeSeleccionImagen(context);
/*_capturarImagem(BuildContext context) async {
    try {
      var _picture = await ImagePicker.pickImage(source: ImageSource.camera);

      setState(() {
        _file = _picture;
        if (_file != null) {

        //_listFile.add(_file);
        }
      });
      Navigator.of(context).pop();
    } on PlatformException {
      print('Error');
    } catch (e) {
      print('El error es :$e');
    }
  }*/
/*Future _mensajeSeleccionImagen(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Seleccione una opción'),
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
                      _capturarImagem(context, 1);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }*/

/*Widget _listaImagenes() {
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
  }*/
