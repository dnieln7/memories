import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:memories/database/db_helper.dart';
import 'package:memories/location/location_helper.dart';
import 'package:memories/model/place.dart';
import 'package:memories/model/place_location.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get places => [..._items];

  Future<void> fetchFromDb() async {
    final rawPlaces = await DBHelper.get('tb_places');
    _items = rawPlaces
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude:item['loc_lon'],
              address: item['loc_address'],
            ),
            image: File(item['image']),
          ),
        )
        .toList();

    notifyListeners();
  }

  Future<void> add(String title, File image, PlaceLocation location) async {
    final address = await LocationHelper.getLocationAddress(
      location.latitude,
      location.longitude,
    );

    location.address = address;

    final place = Place(
      id: DateTime.now().toIso8601String(),
      title: title,
      image: image,
      location: location,
    );

    _items.add(place);

    notifyListeners();

    var data = <String, Object>{
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'loc_lat': place.location.latitude,
      'loc_lon': place.location.longitude,
      'loc_address': place.location.address,
    };

    DBHelper.insert('tb_places', data);
  }
}
