import 'package:flutter/material.dart';

class Help {
  Color white  =Colors.white;
   Color blue  ;
  TextStyle estiloTexto ;
  TextStyle subtitle;
  Widget tituloImagen ;
  Help(){
    blue =  Color(0xFF00003c);
    estiloTexto =  TextStyle(fontSize: 18.0, color: Colors.white, );
    subtitle =  TextStyle(fontSize: 20.0, color: Colors.white,fontWeight: FontWeight.bold );
    tituloImagen = Image.asset('assets/images/logo.png',fit: BoxFit.cover,height: 42,);

  }
    Widget imageSolGas(double size){
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/logo.png',fit: BoxFit.contain,height: size,)
        ],
    );
  }

  
}
final Help help = new Help();