import 'package:memories/location/location_constants.dart';

class LocationHelper {
  static String generateLocationPreviewUrl(
      {double latitude, double longitude}) {
    return '''https://maps.googleapis.com/maps/api/staticmap?center=
    &$latitude, $longitude&zoom=14&size=600x300&maptype=roadmap
    &markers=color:red%7Clabel:A%7C$latitude,$longitude
    &key=$mapsKey''';
  }
}
