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
}

final Help help = new Help();
