import 'package:flutter/material.dart';
import 'dart:async';
import 'package:checkpoint/src/utils/help.dart';
import 'package:flip_card/flip_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
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
      'solgas_01.JPG',
      'solgas_02.jpg',
      'solgas_03.jpg',
      'solgas_04.jpg',
      'solgas_05.JPG',
      'solgas_06.JPG',
      'solgas_07.JPG',
      'solgas_08.JPG',
      'solgas_09.jpg',
      'solgas_10.jpg',
      '11.jpg',
      '12.jpg'
    ]
  };
  int time = 0;
  Timer timer;
  int timeStart = 0;
  Timer timerStart;
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
    Future.delayed(Duration(milliseconds: 500), () {
      messageStart();
    });
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
        _calificaion();
      });
    });
  }

  gameStart() {
    timerStart = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        timeStart++;
        //print(timeStart);
      });
    });
  }

  _calificaion() {
    if (time <= 20) {
      setState(() => nota = 'A');
    } else if (time >= 21 && time <= 30) {
      setState(() => nota = 'B');
    } else if (time >= 31 && time <= 40) {
      setState(() => nota = 'C');
    } else if (time >= 41 && time <= 50) {
      setState(() => nota = 'D');
    } else {
      setState(() => nota = 'F');
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
                    padding: const EdgeInsets.only(
                        left: 20, bottom: 5, right: 20, top: 10),
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.74,
                    child: GridView.builder(
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
                                //print(cardFlips);

                                if (cardFlips.every((t) => t == false)) {
                                  //print("Won");
                                  _gameCompleted();
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
                                  image:
                                      AssetImage('assets/images/gamecard.png'),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                      itemCount: data.length,
                    ),
                  ),
                ],
              ),
            ),
            message: Container()),
      ),
    );
  }

  _gameCompleted() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          /* title: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2), topRight: Radius.circular(2)),
              child: Image.asset(
                'assets/images/completed.gif',
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),*/
          titlePadding: EdgeInsets.all(0),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('COMPLETASTE EL CHECKPOINT VIRTUAL',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent)),
              Text("Tiempo: $time seg",
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                  )),
              Text(
                "Calificación: '$nota'",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                ),
              ),
              Text(
                tablaRangos(nota),
                style: GoogleFonts.roboto(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      _postInformation();
                      Navigator.pop(context);
                      setState(() {});
                    },
                    color: Colors.deepOrangeAccent,
                    child: Text(
                      "ENVIAR",
                      style: GoogleFonts.roboto(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String tablaRangos(String nota) {
    String text;
    switch (nota) {
      case 'A':
        text = 'Excelentes condiciones';
        break;
      case 'B':
        text = 'Buen desempeño';
        break;
      case 'F':
        text = 'Por favor contactar a su superior';
        break;
      default:
        text = '';
    }
    return text;
  }

  messageStart() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                titlePadding: EdgeInsets.all(0),
                /*title: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2),
                          topRight: Radius.circular(2)),
                      child: Image.asset('assets/images/start.gif')),
                ),*/
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'JUEGO DE MEMORIA',
                      style: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Se calificara según los segundos que se demore',
                      style: GoogleFonts.roboto(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.red,
                          onPressed: () {
                            Navigator.of(context).pop();
                            Future.delayed(Duration(milliseconds: 500), () {
                              startTimer();
                            });
                          },
                          child: Text(
                            'INICIAR',
                            style: GoogleFonts.montserrat(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  _postInformation() async {
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      'latitude': '${args['statement']['latitud']}',
      'longitude': '${args['statement']['longitud']}',
      'timestamp': _dateConvert(),
      'game_score': '$time',
      'unitid': '${args['scanner']['unidad']}',
      'driverid': '${args['scanner']['conductor']}',
      'image1': await MultipartFile.fromFile(args['gallery']['img1'].path,
          filename: args['gallery']['img1'].path.split('/').last),
      'image2': await MultipartFile.fromFile(args['gallery']['img2'].path,
          filename: args['gallery']['img2'].path.split('/').last),
      'image3': await MultipartFile.fromFile(args['gallery']['img3'].path,
          filename: args['gallery']['img3'].path.split('/').last),
      'image4': await MultipartFile.fromFile(args['gallery']['img4'].path,
          filename: args['gallery']['img4'].path.split('/').last),
      'image5': await MultipartFile.fromFile(args['gallery']['img5'].path,
          filename: args['gallery']['img5'].path.split('/').last),
      'image6': await MultipartFile.fromFile(args['gallery']['img6'].path,
          filename: args['gallery']['img6'].path.split('/').last),
      'image7': await MultipartFile.fromFile(args['gallery']['img7'].path,
          filename: args['gallery']['img7'].path.split('/').last),
      'image8': await MultipartFile.fromFile(args['gallery']['img8'].path,
          filename: args['gallery']['img8'].path.split('/').last),
      'image9': await MultipartFile.fromFile(args['gallery']['img9'].path,
          filename: args['gallery']['img9'].path.split('/').last),
      'image10': await MultipartFile.fromFile(args['gallery']['img10'].path,
          filename: args['gallery']['img10'].path.split('/').last),
      'image11': await MultipartFile.fromFile(args['gallery']['img11'].path,
          filename: args['gallery']['img11'].path.split('/').last),
      'image12': args['gallery']['img12'] == null
          ? ' '
          : await MultipartFile.fromFile(args['gallery']['img12'].path,
              filename: args['gallery']['img12'].path.split('/').last),
      'checkpoint': args['geozona']['name'],
      'estado': args['status']['estado'],
      'tipo': args['type']['tipooperacion'],
      'time': (DateTime.now().millisecondsSinceEpoch / 1000) -
          args['temporizador']['tiempo']
    });
    try {
      String urlJ = 'http://190.223.43.132:8000/upload/';
      var url = urlJ;
      var response = await dio.post(url, data: formData);
      //print('Response status ${response.statusCode}');
      //print('Response message ${response.statusMessage}');
      if (response.statusCode == 200) {
        _messageStatus200();
        /*args['statement'].forEach((k, v) => print('$k  $v'));
        args['geozona'].forEach((k, v) => print('$k  $v'));
        args['status'].forEach((k, v) => print('$k  $v'));
        args['type'].forEach((k, v) => print('$k  $v'));
        args['gallery'].forEach((k, v) => print('$k  $v'));*/
      }
    } catch (e) {
      print(e);
    }
  }

  String _dateConvert() {
    String hora = '${DateTime.now().millisecondsSinceEpoch / 1000}';
    return hora.split('.').first;
  }

  _messageStatus200() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                  title: Container(
                    child: Image.asset(
                      'assets/images/envio.jpg',
                      fit: BoxFit.cover,
                      height: 150,
                    ),
                  ),
                  content: RaisedButton(
                      onPressed: () {
                        print(args['temporizador']['tiempo']);
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                        // Navigator.pushNamed(context, '/');
                      },
                      color: Colors.red,
                      child: Text('Salir',
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)))),
            ));
  }

  @override
  void dispose() {
    super.dispose();
    startTimer();
  }
}
