import 'package:flutter/material.dart';
import 'package:composter/blocs/navigation_bloc.dart';
import 'package:composter/widgets/compost_guide.dart';
import 'package:composter/widgets/dropoff_detail.dart';
import 'package:composter/widgets/dropoff_map.dart';
import 'package:composter/widgets/search_bar.dart';
import 'package:composter/widgets/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(),
      // body: DropoffMap(),
      body: StreamBuilder<NavigationItem>(
        stream: navigationBloc.bottomNavController.stream,
        initialData: navigationBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavigationItem> snapshot) {
          switch(snapshot.data) {
            case NavigationItem.MAP:
              return Stack(
                children: <Widget>[
                  DropoffMap(),
                  DropoffDetail(),
                ]
              );
            case NavigationItem.INFO:
              return CompostGuide();
          }
        }
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}