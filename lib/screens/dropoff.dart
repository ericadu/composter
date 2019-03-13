import 'package:flutter/material.dart';
import 'package:composter/widgets/dropoff_detail.dart';
import 'package:composter/widgets/dropoff_map.dart';
import 'package:composter/widgets/search_bar.dart';

class DropoffScreen extends StatelessWidget {
  const DropoffScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(),
      body: Stack(
        children: <Widget>[
          DropoffMap(),
          DropoffDetail()
        ]
      ),
    );
  }
}