import 'package:checkpoint/src/utils/help.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<String> _listaNumeros = ['1', '2', '3', '4', '5'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: help.tituloImagen,
        centerTitle: true,
      ),
      body: _crearLista(),
    );
  }

  _crearLista() {
    return ListView.builder(
      itemCount: _listaNumeros.length,
      itemBuilder: (BuildContext context, int index) {
        //String indice = _listaNumeros[index];
        return Container(
          decoration: BoxDecoration(boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 10.0,
                spreadRadius: 5.0,
                offset: Offset(2.0, 5.0)),
          ]),
          margin: EdgeInsets.only(bottom: 20.0, left: 15.0, right: 15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: Colors.blue,
              child: Column(
                children: <Widget>[
                  FadeInImage(
                    placeholder: AssetImage('assets/images/Ripple.gif'),
                    image: NetworkImage(
                        'https://picsum.photos/500/300/?image=$index'),
                  ),
                  Text('En numeor de la imagen es $index'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
