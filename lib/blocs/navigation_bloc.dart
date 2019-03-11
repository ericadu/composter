import 'package:rxdart/rxdart.dart';

enum NavigationItem {
  MAP,
  INFO,
}

class NavigationBloc {
  NavigationItem defaultItem = NavigationItem.MAP;

  final PublishSubject<NavigationItem> _bottomNavController = PublishSubject<NavigationItem>();

  void dispose(){
    _bottomNavController.close();
  }

  void pickItem(int i) {
    switch(i) {
      case 0:
        _bottomNavController.sink.add(NavigationItem.MAP);
        break;
      case 1:
        _bottomNavController.sink.add(NavigationItem.INFO);
        break;
    }
  }

  PublishSubject<NavigationItem> get bottomNavController  => _bottomNavController ;
}

final navigationBloc = NavigationBloc();