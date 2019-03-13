import 'package:flutter/material.dart';
import 'package:composter/widgets/compost_guide.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compost Guide"),
      ),
      body: CompostGuide()
    );
  }
}