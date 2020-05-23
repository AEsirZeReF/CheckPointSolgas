import 'package:flutter/material.dart';
import 'package:checkpoint/src/utils/help.dart';

import 'package:google_fonts/google_fonts.dart';

class TypeChannelPage extends StatefulWidget {
  TypeChannelPage({Key key}) : super(key: key);

  @override
  _TypeChannelPageState createState() => _TypeChannelPageState();
}

class _TypeChannelPageState extends State<TypeChannelPage> {
  bool granel = false;
  bool envasado = false;
  var args;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments
        as Map<String, Map<String, dynamic>>;
    return Container(
        child: WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            title: help.tituloImagen,
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: help.blue,
          ),
          backgroundColor: help.blue,
          body: help.layoutFondo(
            context,
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * 0.18)),
                  Text(
                    'Seleccionar el tipo',
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 33,
                    ),
                  ),
                  Text(
                    'de operación',
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 33,
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.white,
                              ),
                              child: new Transform.scale(
                                scale: 1.4,
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.blue[500],
                                  value: granel,
                                  onChanged: (bool val) {
                                    granel = val;
                                    //print('este es granel :$granel');
                                    setState(() {
                                      args['type']['tipooperacion'] = 'granel';
                                      if (envasado) {
                                        envasado = false;
                                      }
                                    });
                                  },
                                ),
                              )),
                          Text(
                            'GRANEL ',
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.white,
                              ),
                              child: new Transform.scale(
                                scale: 1.4,
                                child: Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.blue[500],
                                    value: envasado,
                                    onChanged: (value) {
                                      envasado = value;
                                      setState(() {
                                        args['type']['tipooperacion'] =
                                            'envasado';
                                        //print('este es envasado :$envasado');
                                        if (granel) {
                                          granel = false;
                                        }
                                      });
                                    }),
                              )),
                          Text(
                            'ENVASADO ',
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: help.botonera(context, () {
            if (granel) {
              Navigator.pushNamed(context, '/gallery', arguments: args);
            } else {
              Navigator.pushNamed(context, '/galleryenvasado', arguments: args);
            }
          }, color: Color(0xFF4e619b), texto: 'Continuar')),
    ));
  }
}
