import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:memories/model/place.dart';

class PlaceProvider with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get places => [..._items];

  void add(String title, File image) {
    final place = Place(
      id: DateTime.now().toIso8601String(),
      title: title,
      image: image,
      location: null,
    );

    _items.add(place);

    notifyListeners();
  }
}
