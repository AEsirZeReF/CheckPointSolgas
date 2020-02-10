import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:image_save/image_save.dart';
import 'package:dio/dio.dart';

class Imagesave extends StatefulWidget {
  Imagesave({Key key}) : super(key: key);

  @override
  _ImagesaveState createState() => _ImagesaveState();
}

class _ImagesaveState extends State<Imagesave> {
  String _imagePath = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _saveImage() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    String imagePath = "";
    try {
      Response<List<int>> res = await Dio().get<List<int>>(
          "https://picsum.photos/200/300.jpg",
          options: Options(responseType: ResponseType.bytes));
      imagePath =
          await ImageSave.saveImage("jpg", Uint8List.fromList(res.data));
    } on PlatformException {
      imagePath = '未能保存成功';
    }
    setState(() {
      _imagePath = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeInImage(
                placeholder: AssetImage('assets/images/BeanEater.gif'),
                image: NetworkImage('https://picsum.photos/200/300.jpg')),
            Text('La ruta es $_imagePath')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveImage();
        },
        child: Icon(Icons.save_alt),
      ),
    );
  }
}
