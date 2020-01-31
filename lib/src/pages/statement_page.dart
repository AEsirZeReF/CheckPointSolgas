import 'package:checkpoint/src/utils/help.dart';
import 'package:flutter/material.dart';

class Statement extends StatelessWidget{
  //final blue =  Color(0xFF00003c);
  //final estiloTexto = new TextStyle(fontSize: 18.0, color: Colors.white, );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:  help.tituloImagen,
        backgroundColor: help.blue,
        centerTitle: true,
        ),
        backgroundColor: help.blue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
                SizedBox(height: 50.0,),
                Container(
                  child: Text('Declaración Jurada',style: TextStyle(color: help.white,fontSize: 22.0),),
                ),
                SizedBox(height: 50.0,),
                Container(
                  width: 300,
                  height: 400,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                      children: <Widget>[
                          Text('Al contrario del pensamiento popular, el texto de Lorem Ipsum no es simplemente texto aleatorio. Tiene sus raices en una pieza cl´sica de la literatura del Latin, que data del año 45 antes de Cristo, haciendo que este adquiera mas de 2000 años de antiguedad. Richard McClintock, un profesor de Latin de la Universidad de Hampden-Sydney en Virginia, encontró una de las palabras más oscuras de la lengua del latín, "consecteur", en un pasaje de Lorem Ipsum, y al seguir leyendo distintos textos del latín, descubrió la fuente indudable. Lorem Ipsum viene de las secciones 1.10.32 y 1.10.33 de "de Finnibus Bonorum et Malorum" (Los Extremos del Bien y El Mal) por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum, "Lorem ipsum dolor sit amet..", viene de una linea en la sección 1.10.32',style: help.estiloTexto,textAlign: TextAlign.justify,),
                          Text('Al contrario del pensamiento popular, el texto de Lorem Ipsum no es simplemente texto aleatorio. Tiene sus raices en una pieza cl´sica de la literatura del Latin, que data del año 45 antes de Cristo, haciendo que este adquiera mas de 2000 años de antiguedad. Richard McClintock, un profesor de Latin de la Universidad de Hampden-Sydney en Virginia, encontró una de las palabras más oscuras de la lengua del latín, "consecteur", en un pasaje de Lorem Ipsum, y al seguir leyendo distintos textos del latín, descubrió la fuente indudable. Lorem Ipsum viene de las secciones 1.10.32 y 1.10.33 de "de Finnibus Bonorum et Malorum" (Los Extremos del Bien y El Mal) por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum, "Lorem ipsum dolor sit amet..", viene de una linea en la sección 1.10.32',style:  help.estiloTexto,textAlign: TextAlign.justify,)
                      ],
                  )
                )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: RaisedButton(
        onPressed:(){
          Navigator.pushNamed(context, '/geozona');
        },
              color: help.white,
              textColor: help.blue,
              child: new Text('Estoy Conforme'),
      )
    );
      }
 
}
