import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  SearchBar({Key key}) : preferredSize = Size.fromHeight(56.0), super(key: key);
  final Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  @override
  final Size preferredSize;

  @override
  SearchBarState createState() => new SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  Icon _actionIcon = new Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: new IconButton(
      //   icon: _searchIcon,
      //   onPressed: _searchPressed,
      // ),
      // title: new TextField(
      //   decoration: new InputDecoration(
      //     prefixIcon: _searchIcon,
      //     hintText: 'Search nearest dropoff...'
      //   ),
      // ),
      title: new Text('Compost Dropoff Locations'),
      actions: <Widget> [
        new IconButton(icon: _actionIcon, onPressed:() {})
      ],
    );
  }
}