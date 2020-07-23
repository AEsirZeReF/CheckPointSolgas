import 'package:flutter/material.dart';
import 'package:checkpoint/src/utils/help.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusPage extends StatefulWidget {
  StatusPage({Key key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  bool start = false;
  bool stop = false;
  bool rest = false;
  var args;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments
        as Map<String, Map<String, dynamic>>;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            title: help.tituloImagen,
            backgroundColor: help.blue,
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          backgroundColor: help.blue,
          body: Center(
            child: help.layoutFondo(
                context,
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.width * 0.16)),
                      Text(
                        'Seleccionar el estado ',
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 33,
                        ),
                      ),
                      Text(
                        'del CHECKPOINT',
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 33,
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                      Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.23),
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
                                      value: start,
                                      onChanged: (bool val) {
                                        setState(() {
                                          start = val;
                                          args['status']['estado'] = 'inicio';
                                          if (stop || rest) {
                                            stop = false;
                                            rest = false;
                                          }
                                        });
                                      },
                                    ),
                                  )),
                              Text(
                                'Inicio ',
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                              Image.asset(
                                "assets/images/start.png",
                                width: 30,
                              )
                            ],
                          )),
                      Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.23),
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
                                        value: stop,
                                        onChanged: (value) {
                                          setState(() {
                                            stop = value;
                                            args['status']['estado'] = 'parada';
                                            if (start || rest) {
                                              start = false;
                                              rest = false;
                                            }
                                          });
                                        }),
                                  )),
                              Text(
                                'Parada ',
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                              Image.asset(
                                "assets/images/stop.png",
                                width: 30,
                              )
                            ],
                          )),
                      Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.23),
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
                                        value: rest,
                                        onChanged: (value) {
                                          setState(() {
                                            rest = value;
                                            args['status']['estado'] =
                                                'descanso';
                                            if (start || stop) {
                                              start = false;
                                              stop = false;
                                            }
                                          });
                                        }),
                                  )),
                              Text(
                                'Descanso ',
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                              Image.asset(
                                "assets/images/rest.png",
                                width: 30,
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                message: Container()),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: help.botonera(context, () {
            if (start || stop || rest) {
              Navigator.pushNamed(context, '/scanner', arguments: args);
            }
          }, color: Color(0xFF4e619b), texto: 'Continuar')),
    );
  }
}
