import 'package:flutter/material.dart';
import 'package:composter/repositories/compost_guidelines_respository.dart';
import 'package:composter/models/compost_guidelines.dart';

class CompostGuide extends StatefulWidget {
  @override
  State<CompostGuide> createState() => CompostGuideState();
}

class CompostGuideState extends State<CompostGuide> {
  final CompostGuidelinesRepository _compostGuideRepo = CompostGuidelinesRepository();

  @override
  Widget build(BuildContext context) {
    return _buildAccepted();
  }

  Widget _buildAccepted() {
    CompostGuidelines guidelines = _compostGuideRepo.getNYCDefaultGuidelines();
    List<Widget> widgets = <Widget>[];

    guidelines.accepted.forEach((a) => {
      widgets.add(ListTile(
        leading: Icon(Icons.check_circle, color: Colors.green),
        title: Text(a)
      ))
    });

    guidelines.notAccepted.forEach((na) => {
      widgets.add(ListTile(
        leading: Icon(Icons.cancel, color: Colors.red),
        title: Text(na)
      ))
    });
    return ListView(
      children: widgets,
    );
  }
}