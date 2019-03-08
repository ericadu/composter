import 'package:flutter/material.dart';
import 'package:composter/blocs/dropoff_locations_bloc.dart';
import 'package:composter/models/dropoff_location.dart';

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
  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DropoffLocation>(
      stream: bloc.focusController.stream,
      builder: (context, AsyncSnapshot<DropoffLocation> snapshot) {
        if (snapshot.hasData) {
          return AppBar(
            centerTitle: false,
            leading: Icon(Icons.location_on),
            title: new Text(
              snapshot.data.siteName,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 19.0,
              )
            ),
            actions: <Widget> [
            new IconButton(icon: Icon(Icons.close), onPressed:() => bloc.focusController.sink.add(null))
          ],
          );
        }
        return AppBar(
          centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.location_searching),
            onPressed: () {
              
            },
          ),
          title: TextField(
            decoration: InputDecoration(
              hintText: "No selection.",
            ),
            enabled: false,
          )
        );
      }
    );
  }
}