import 'dart:async';

import 'package:checkpoint/src/utils/help.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

int level = 8;

class GamePage extends StatefulWidget {
  final int size;
  const GamePage({Key key, this.size = 8}) : super(key: key);

  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  List<bool> cardFlips = [];
  List<String> data = [];
  int previousIndex = -1;
  bool flip = false;
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
    level == 16
        ? showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text("Usted completado el formulario Solgas"),
              content: Text(
                "Time $time",
                style: Theme.of(context).textTheme.display2,
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Text("Finish"),
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
}
