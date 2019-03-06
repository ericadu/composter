import 'package:flutter/material.dart';
import 'package:composter/widgets/dropoff_map.dart';
import 'package:composter/widgets/search_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(),
      body: DropoffMap(),
    );
  }
}