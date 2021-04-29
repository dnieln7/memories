import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:memories/model/place_location.dart';

class Place {
  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });

  final String id;
  final String title;
  final PlaceLocation location;
  final File image;
}
