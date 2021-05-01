import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:memories/location/location_helper.dart';

class LocationField extends StatefulWidget {
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
              onPressed: () => {},
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
  }
}
