import 'package:UpCloud_app/show2.dart';
import 'package:flutter/material.dart';
import 'save.dart';
import 'show.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/save',
    routes: {
      '/save': (context) => MyApp(),
      '/show': (context) => Page1(),
    },
  ));
}
