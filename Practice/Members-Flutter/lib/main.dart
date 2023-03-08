import 'package:flutter/material.dart';
import 'ghflutter.dart';
import 'strings.dart' as strings;

void main() => runApp(const GHFlutterApp());

class GHFlutterApp extends StatelessWidget {
  const GHFlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: strings.appTitle,
      theme: ThemeData(primarySwatch: Colors.green), 
      home: const GHFlutter(),
    );
  }
}