import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DropoffMap extends StatefulWidget {
  @override
  State<DropoffMap> createState() => DropoffMapState();
}

class DropoffMapState extends State<DropoffMap> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _manhattan = CameraPosition(
    target: LatLng(40.731506, -73.983427),
    zoom: 12,
  );


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: _manhattan,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ]
      ),
    );
  }
}