import 'package:flutter/material.dart';
import 'dart:async';
import 'package:checkpoint/src/utils/help.dart';
import 'package:flip_card/flip_card.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';

class GamePage extends StatefulWidget {
  final int size;
  const GamePage({Key key, this.size = 12}) : super(key: key);

  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  List<bool> cardFlips = [];
  List<String> data = [];
  int previousIndex = -1;
  bool flip = false;
  var args;
  Map<String, List<String>> _coleccionImagenes = {
    'imagen': [
      '01.png',
      '02.jpg',
      '03.jpg',
      '04.jpg',
      '05.jpg',
      '06.jpg',
      '07.jpg',
      '08.jpg',
      '09.jpg',
      '10.jpg',
      '11.jpg',
      '12.jpg'
    ]
  };
  int time = 0;
  Timer timer;
  String nota = 'Nota';
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.size; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }
    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(i.toString());
    }
    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(i.toString());
    }

    data.shuffle();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
        _calificaion();
      });
    });
  }

  _calificaion() {
    if (time <= 20) {
      setState(() => nota = 'A');
    } else if (time <= 40 && time > 20) {
      setState(() => nota = 'B');
    } else if (time <= 60 && time > 40) {
      setState(() => nota = 'C');
    } else {
      setState(() => nota = 'Jalado!');
    }
  }

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
          automaticallyImplyLeading: false,
          backgroundColor: help.blue,
        ),
        backgroundColor: help.blue,
        body: help.layoutFondo(
            context,
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, bottom: 20, right: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Tiempo: ',
                          style: GoogleFonts.roboto(
                              fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          '$time',
                          style: GoogleFonts.roboto(
                              fontSize: 30, color: Colors.white),
                        ),
                        Expanded(child: Container()),
                        Text(
                          'Score: ',
                          style: GoogleFonts.roboto(
                              fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          '$nota',
                          style: GoogleFonts.roboto(
                              fontSize: 30, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) => FlipCard(
                      key: cardStateKeys[index],
                      onFlip: () {
                        if (!flip) {
                          flip = true;
                          previousIndex = index;
                        } else {
                          flip = false;
                          if (previousIndex != index) {
                            if (data[previousIndex] != data[index]) {
                              cardStateKeys[previousIndex]
                                  .currentState
                                  .toggleCard();
                              previousIndex = index;
                            } else {
                              cardFlips[previousIndex] = false;
                              cardFlips[index] = false;
                              print(cardFlips);

                              if (cardFlips.every((t) => t == false)) {
                                print("Won");
                                showResult();
                                setState(() => timer.cancel());
                              }
                            }
                          }
                        }
                      },
                      direction: FlipDirection.HORIZONTAL,
                      flipOnTouch: cardFlips[index],
                      front: Container(
                        margin: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white),
                            image: DecorationImage(
                                image: AssetImage('assets/images/gamecard.png'),
                                fit: BoxFit.cover)),
                      ),
                      back: Container(
                        margin: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/images/${_coleccionImagenes['imagen'][int.parse(data[index])]}'))),
                        child: Center(
                          child: Text(
                            "${data[index]}",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                    itemCount: data.length,
                  ),
                ],
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: RaisedButton(
            onPressed: () {
              startTimer();
            },
            color: Color(0xFF4e619b),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              child: Text(
                'Iniciar Test!',
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              /*side: BorderSide(width: 2, color: Colors.lightBlue)*/
            )),
      ),
    );
  }

  showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          "Usted completado el formulario Solgas",
          style: GoogleFonts.roboto(color: Colors.lightBlueAccent),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Tiempo: $time",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                )),
            Text(
              "Calificación: $nota",
              style: GoogleFonts.roboto(
                fontSize: 20,
              ),
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              _postInformation();
              Navigator.pop(context);
              setState(() {});
            },
            child: Text(
              "Enviar Datos",
              style:
                  GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  _postInformation() async {
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      'latitude': '${args['statement']['latitud']}',
      'longitude': '${args['statement']['longitud']}',
      'timestamp': 'Es tarde',
      'game_score': '$time',
      'unitid': 'placa',
      'driverid': '12345678',
      'image1': args['gallery']['img1'],
      'image2': args['gallery']['img2'],
      'image3': args['gallery']['img3'],
      'image4': args['gallery']['img4'],
      'image5': args['gallery']['img5']
    });
    try {
      String urlJ = 'http://190.223.43.132:8000/upload/';
      var url = urlJ;
      var response = await dio.post(url, data: formData);
      print('Response status ${response.statusCode}');
      print('Response message ${response.statusMessage}');
      if (response.statusCode == 200) {
        _messageStatus200();
      }
    } catch (e) {
      print(e);
    }
  }

  _messageStatus200() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text('Alert'),
              content: Text(
                'Se envio exitosamente',
                style: GoogleFonts.roboto(fontSize: 20),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      /* SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');*/
                      Navigator.pushNamed(context, '/');
                    },
                    child: Text('Salir',
                        style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold)))
              ],
            ));
  }

  @override
  void dispose() {
    super.dispose();
    startTimer();
  }
}
