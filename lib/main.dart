import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ImagesState();
}

class ImagesState extends State {
  String rootCatOrigin = 'images/cat_origin.jpg';
  String rootCatClone = "images/cat_origin.jpg";
  String rootDogOrigin = "images/cat_origin.jpg";
  String rootDogClone = "images/cat_origin.jpg";

  bool result = false;

  @override
  Widget build(BuildContext context) {
    isIdenticalImages(rootCatOrigin, rootCatOrigin)
        .then((value) => result = value);
    return Scaffold(
        appBar: AppBar(
          title: Text('Test App'),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                color: Colors.amber,
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          rootCatClone,
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                          child: Image.asset(
                        rootCatOrigin,
                        width: 150,
                        height: 150,
                      )),
                    )
                  ],
                ),
              )),
              const Divider(
                color: Colors.black,
                height: 20,
                thickness: 5,
                endIndent: 0,
              ),
              Expanded(
                child: Container(
                  color: Colors.lightBlue,
                  child: Center(
                    child: Text('identical images: $result'),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<bool> isIdenticalImages(String rootImage1, String rootImage2) async {
    ByteData bytes1 = await rootBundle.load(rootImage1);
    ByteData bytes2 = await rootBundle.load(rootImage2);

    int bytesInInt1 = bytes1.getInt64(64);
    int bytesInInt2 = bytes2.getInt64(64);

    if (bytesInInt1 != bytesInInt2) {
      return false;
    } else
      return true;
  }
}
