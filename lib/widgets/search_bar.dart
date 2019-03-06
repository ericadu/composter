import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  SearchBar({Key key}) : preferredSize = Size.fromHeight(56.0), super(key: key);

  @override
  final Size preferredSize;

  @override
  SearchBarState createState() => new SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  Icon _searchIcon = new Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      )
    );
  }

  void _searchPressed() {
    //
  }
}