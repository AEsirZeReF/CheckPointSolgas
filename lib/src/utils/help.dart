import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Help {
  Color white = Colors.white;
  Color blue;
  TextStyle estiloTexto;
  TextStyle subtitle;
  TextStyle parrafo;
  Widget tituloImagen;
  Help() {
    blue = Color(0xFF0b2265);
    subtitle = GoogleFonts.montserrat(color: Colors.white, fontSize: 24);
    estiloTexto = GoogleFonts.lato(color: Colors.white, fontSize: 20);
    parrafo = GoogleFonts.lato(color: Colors.white, fontSize: 18);
    tituloImagen = Image.asset(
      'assets/images/logo.png',
      fit: BoxFit.cover,
      height: 42,
    );
  }
  Widget imageSolGas(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
          height: size,
        )
      ],
    );
  }

  Map<String, double> contentSize(BuildContext context) {
    double width = MediaQuery.of(context).size.shortestSide;
    double height = MediaQuery.of(context).size.height;
    Map<String, double> _medidas = {'width': width, 'heigth': height};
    return _medidas;
  }

  Widget botonSiguiente(BuildContext context, String ruta, String texto) {
    return FlatButton.icon(
      color: Colors.white,
      onPressed: () {
        Navigator.pushNamed(context, ruta);
      },
      icon: Icon(
        Icons.check,
        color: help.blue,
      ),
      label: Text(
        texto,
        style: TextStyle(color: help.blue, fontSize: 16),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: BorderSide(width: 1.5, color: Colors.deepOrange)),
    );
  }

  //diseño del fondo
  Stack layoutFondo(BuildContext context, Widget newWidget) {
    return Stack(
      children: <Widget>[
        Container(
          color: Color(0xFF2e4792),
          //decoration: BoxDecoration(borderRadius: BorderRadius.only()),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.90,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(500)),
                color: Color(0xFF19317a)),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.70,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(500)),
                color: help.blue),
          ),
        ),
        /*Align(
          alignment: Alignment.topRight,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.50,
            height: MediaQuery.of(context).size.height * 0.30,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(500)),
                color: Color(0xFFff6a00)),
          ),
        ),*/
        /*Align(
          alignment: Alignment.topRight,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.40,
            height: MediaQuery.of(context).size.height * 0.19,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(500)),
                color: Color(0xFFff8b39)),
          ),
        ),*/
        /* Align(
          alignment: Alignment.topRight,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.30,
            height: MediaQuery.of(context).size.height * 0.11,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(500)),
                color: Color(0xFFffa464)),
          ),
        ),*/
        newWidget
      ],
    );
  }
}

final Help help = new Help();
