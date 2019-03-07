import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:composter/blocs/dropoff_locations_bloc.dart';
import 'package:composter/models/dropoff_location.dart';

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
  void initState() {
    super.initState();
    bloc.getLocations();
  }


  @override
  Widget build(BuildContext context) {
    //final DropoffLocationsBloc bloc = BlocProvider.of<DropoffLocationsBloc>(context);
    return StreamBuilder<List<DropoffLocation>>(
      stream: bloc.locationsController.stream,
      builder: (context, AsyncSnapshot<List<DropoffLocation>> snapshot) {
        if (snapshot.hasData) {
          Set<Marker> markers = _addMarkers(snapshot.data);

          return GoogleMap(
            initialCameraPosition: _manhattan,
            onMapCreated: _onMapCreated,
            markers: markers,
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // return Center(child:CircularProgressIndicator());  
        return GoogleMap(
          initialCameraPosition: _manhattan,
          onMapCreated: _onMapCreated,
        );
      }
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Set<Marker> _addMarkers(List<DropoffLocation> locations) {
    Set<Marker> markers = Set<Marker>();

    locations.forEach((loc) =>
      markers.add(
        Marker(
          markerId:MarkerId(loc.id.toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(loc.latitude, loc.longitude),
        )
      )
    );

    return markers;
  }
}