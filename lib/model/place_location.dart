import 'package:flutter/foundation.dart';

class PlaceLocation {
  PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });

  final double latitude;
  final double longitude;
  String address;
}
