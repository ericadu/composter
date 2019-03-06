import 'package:flutter/material.dart';
import 'package:composter/screens/home.dart';

void main() => runApp(ComposterApp());
class ComposterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NYC Compost Dropoff',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: HomePage(),
    );
  }
}