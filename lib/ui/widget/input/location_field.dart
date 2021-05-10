import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:memories/location/location_helper.dart';
import 'package:memories/model/place_location.dart';
import 'package:memories/ui/page/map/map_view.dart';

class LocationField extends StatefulWidget {
  LocationField(this.onSaveLocation);

  final Function onSaveLocation;

  @override
  _LocationFieldState createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  String previewImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          child: previewImageUrl == null
              ? Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  previewImageUrl,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on_sharp),
              label: Text('Current location'),
              onPressed: getCurrentLocation,
            ),
            TextButton.icon(
              icon: Icon(Icons.map_sharp),
              label: Text('Select on map'),
              onPressed: openMap,
            )
          ],
        ),
      ],
    );
  }

  Future<void> getCurrentLocation() async {
    final location = await Location().getLocation();
    final url = LocationHelper.generateLocationPreviewUrl(
      latitude: location.latitude,
      longitude: location.longitude,
    );

    setState(() => previewImageUrl = url);

    widget.onSaveLocation(location.latitude, location.longitude);
  }

  Future<void> openMap() async {
    final location = await Location().getLocation();

    final selectedLocation = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapView(
          initLocation: PlaceLocation(
            latitude: location.latitude,
            longitude: location.longitude,
          ),
          readOnly: false,
        ),
      ),
    );

    if (selectedLocation != null) {
      final url = LocationHelper.generateLocationPreviewUrl(
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude,
      );

      setState(() => previewImageUrl = url);

      widget.onSaveLocation(selectedLocation.latitude, selectedLocation.longitude);
    }
  }
}
