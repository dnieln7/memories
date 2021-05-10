import 'package:geocoding/geocoding.dart';
import 'package:memories/location/location_constants.dart';

class LocationHelper {
  static String generateLocationPreviewUrl(
      {double latitude, double longitude}) {
    return '''https://maps.googleapis.com/maps/api/staticmap?center=
    &$latitude, $longitude&zoom=15&size=600x300&maptype=roadmap
    &markers=color:red%7Clabel:A%7C$latitude,$longitude
    &key=$mapsKey''';
  }

  static Future<String> getLocationAddress(double lat, double lon) async {
    final response = await placemarkFromCoordinates(lat, lon);
    final data = response.first;

    return '${data.street}, ${data.locality}, ${data.administrativeArea}, ${data.country}';
  }
}
