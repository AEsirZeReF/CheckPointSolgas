import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Swipper extends StatefulWidget {
  Swipper({Key key}) : super(key: key);

  @override
  _SwipperState createState() => _SwipperState();
}

class _SwipperState extends State<Swipper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('swipper'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Swiper(
          curve: Curves.bounceInOut,
          duration: 5000,
          layout: SwiperLayout.DEFAULT,
          itemWidth: 300,
          itemHeight: 300,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                color: Colors.limeAccent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(
                          'Titulo ${index + 1}',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    Image.network(
                      "https://picsum.photos/id/237/300/400",
                      fit: BoxFit.cover,
                    ),
                    ListTile(
                      title: Text(''),
                    )
                  ],
                ));
          },
          itemCount: 5,
          pagination: new SwiperPagination(),
          control: new SwiperControl(),
        ),
      ),
    );
  }
}
