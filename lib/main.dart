import 'package:flutter/material.dart';
import 'package:flutter_application_7/screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
