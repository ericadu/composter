import 'package:flutter/material.dart';
import 'package:composter/blocs/navigation_bloc.dart';
import 'package:composter/screens/dropoff.dart';
import 'package:composter/screens/guide.dart';

class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<Widget> pages = [
    DropoffScreen(
      key: PageStorageKey(NavigationItem.MAP),
    ),
    GuideScreen(
      key: PageStorageKey(NavigationItem.INFO),
    ),
  ];  

  final PageStorageBucket bucket = PageStorageBucket();

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
        return Scaffold(
          bottomNavigationBar: _bottomNavigationBar(snapshot.data),
          body: PageStorage(
            child: pages[snapshot.data.index],
            bucket: bucket,
          )
        );
      }
    );
  }

  Widget _bottomNavigationBar(NavigationItem item) {
    return BottomNavigationBar(
      currentIndex: item.index,
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
}
