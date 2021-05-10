import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memories/location/location_helper.dart';
import 'package:memories/model/place_location.dart';

class MapView extends StatefulWidget {
  MapView({@required this.initLocation, this.readOnly = true});

  final PlaceLocation initLocation;
  final readOnly;

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  LatLng pickedLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select your location'),
        actions: [
          if (!widget.readOnly && pickedLocation != null)
            IconButton(
              icon: Icon(Icons.check_sharp, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(pickedLocation),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initLocation.latitude,
            widget.initLocation.longitude,
          ),
          zoom: 15,
        ),
        onTap: (argument) => widget.readOnly ? null : selectLocation(argument),
        markers: pickedLocation == null
            ? {}
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: pickedLocation,
                ),
              },
      ),
    );
  }

  void selectLocation(LatLng position) {
    setState(() => pickedLocation = position);
  }
}
