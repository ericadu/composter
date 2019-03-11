import 'package:flutter/material.dart';
import 'package:composter/blocs/navigation_bloc.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBarState createState() => new BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  @override
  void dispose() {
    navigationBloc.dispose();
    super.dispose();
  }

    @override
  Widget build(BuildContext context) {
    return StreamBuilder<NavigationItem>(
      stream: navigationBloc.bottomNavController.stream,
      initialData: navigationBloc.defaultItem,
      builder: (context, AsyncSnapshot<NavigationItem> snapshot) {
        return BottomNavigationBar(
          currentIndex: snapshot.data.index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Text('Map'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              title: Text('Guide')
            )
          ],
          onTap: navigationBloc.pickItem
        );
      }
    );
  }
}