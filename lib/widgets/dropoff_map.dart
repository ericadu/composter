import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:composter/blocs/dropoff_locations_bloc.dart';
import 'package:composter/models/dropoff_location.dart';

class DropoffMap extends StatefulWidget {
  @override
  State<DropoffMap> createState() => DropoffMapState();
}

class DropoffMapState extends State<DropoffMap> with AutomaticKeepAliveClientMixin {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

  CameraPosition _initial = CameraPosition(
    target: LatLng(40.731506, -73.983427),
    zoom: 14,
  );

  @override
  void dispose() {
    //bloc.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void refresh() async {
    bloc.getLocations();
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: position == null ? _initial : LatLng(position.latitude, position.longitude), zoom: 15.0)));
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<List<DropoffLocation>>(
      stream: bloc.locationsController.stream,
      builder: (context, AsyncSnapshot<List<DropoffLocation>> snapshot) {
        if (snapshot.hasData) {
          Set<Marker> markers = _addMarkers(snapshot.data, context);
          return GoogleMap(
            initialCameraPosition: _initial,
            onMapCreated: _onMapCreated,
            markers: markers,
            myLocationEnabled: true,
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return CircularProgressIndicator();
      }
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    mapController = controller;
    refresh();
  }

  BitmapDescriptor _getLocator(DropoffLocation loc) {
    Status status = loc.getStatus();

    if (status == Status.open || status == Status.probably_open) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    }

    return BitmapDescriptor.defaultMarker;
  }

  double _getAlpha(DropoffLocation loc) {
    Status status = loc.getStatus();

    if (status == Status.open || status == Status.probably_open) {
      return 1.0;
    }

    return 0.6;
  }

  Set<Marker> _addMarkers(List<DropoffLocation> locations, BuildContext context) {
    Set<Marker> markers = Set<Marker>();

    locations.forEach((loc) =>
      markers.add(
        Marker(
          markerId: MarkerId(loc.id.toString()),
          icon: _getLocator(loc),
          position: LatLng(loc.latitude, loc.longitude),
          onTap: () => bloc.focusController.sink.add(loc),
          alpha: _getAlpha(loc),
        )
      )
    );

    return markers;
  }
}