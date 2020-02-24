import 'package:flutter/material.dart';
import 'dart:async';
import 'package:checkpoint/src/utils/help.dart';
import 'package:flip_card/flip_card.dart';
import 'package:dio/dio.dart';

int level = 12;

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
    startTimer();
    data.shuffle();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments
        as Map<String, Map<String, dynamic>>;
    return Scaffold(
      appBar: AppBar(
        title: help.tituloImagen,
        centerTitle: true,
        actions: <Widget>[Text('$time')],
        automaticallyImplyLeading: false,
        backgroundColor: help.blue,
      ),
      backgroundColor: help.blue,
      body: help.layoutFondo(
          context,
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  /*Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "$time",
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
              ),*/
                  Theme(
                    data: ThemeData.dark(),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
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
                                  print(cardFlips);

                                  if (cardFlips.every((t) => t == false)) {
                                    print("Won");
                                    showResult();
                                  }
                                }
                              }
                            }
                          },
                          direction: FlipDirection.HORIZONTAL,
                          flipOnTouch: cardFlips[index],
                          front: Container(
                            margin: EdgeInsets.all(4.0),
                            //color: Colors.deepOrange,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/gamecard.png'),
                                    fit: BoxFit.cover)),
                            //child: Image.asset('assets/images/img1.jpg'),
                          ),
                          back: Container(
                            margin: EdgeInsets.all(4.0),
                            //color: Color(0xFFd88231),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/${_coleccionImagenes['imagen'][int.parse(data[index])]}'))),

                            child: Center(
                              child: Text(
                                "${data[index]}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                        itemCount: data.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  showResult() {
    level == 12
        ? showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text("Usted completado el formulario Solgas"),
              content: Text(
                "tiempo $time",
                style: Theme.of(context).textTheme.display2,
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    _postInformation();
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: Text("Enviar Datos"),
                ),
              ],
            ),
          )
        : showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text("Won!!!"),
              content: Text(
                "Time $time",
                style: Theme.of(context).textTheme.display2,
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => GamePage(
                          size: level,
                        ),
                      ),
                    );
                    level *= 2;
                  },
                  child: Text("NEXT"),
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
              content: Text('Se envio exitosamente'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      /* SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');*/
                      Navigator.pushNamed(context, '/');
                    },
                    child: Text('Salir'))
              ],
            ));
  }
}
