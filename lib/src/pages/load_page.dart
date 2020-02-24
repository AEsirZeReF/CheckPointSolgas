import 'package:checkpoint/src/pages/statement_page.dart';
import 'package:checkpoint/src/utils/help.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:page_transition/page_transition.dart';

class LoadPage extends StatefulWidget {
  LoadPage({Key key}) : super(key: key);

  @override
  _LoadPageState createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {
  bool _visible = false;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 4), () {
      //Navigator.pushNamed(context, '/statement');
      Navigator.push(
          context,
          PageTransition(
            child: Statement(),
            type: PageTransitionType.fade,
            curve: Curves.fastOutSlowIn,
            duration: Duration(seconds: 1),
          ));
    });
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _visible = !_visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: help.blue,
      body: Center(
        child: help.layoutFondo(
            context,
            Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Expanded(child: Container()),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: MediaQuery.of(context).size.width,
                      child: AnimatedOpacity(
                          opacity: _visible ? 1.0 : 0.0,
                          duration: Duration(seconds: 2),
                          child: Image.asset('assets/images/logo.png')),
                    ),
                    Expanded(child: Container()),
                    Container(
                        child: Column(
                      children: <Widget>[
                        AnimatedOpacity(
                          opacity: _visible ? 1.0 : 0.0,
                          duration: Duration(seconds: 2),
                          child: Loading(
                            indicator: BallPulseIndicator(),
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        AnimatedOpacity(
                            opacity: _visible ? 1.0 : 0.0,
                            duration: Duration(seconds: 2),
                            child: Text(
                              'CheckPoint Virtual',
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white),
                            )),
                        AnimatedOpacity(
                            opacity: _visible ? 1.0 : 0.0,
                            duration: Duration(seconds: 2),
                            child: Text('By Segursat',
                                style: GoogleFonts.montserrat(
                                    fontSize: 20, color: Colors.white))),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        )
                      ],
                    )),
                  ],
                ))),
      ),
    );
  } //
}
