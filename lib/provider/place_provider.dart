import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:memories/database/db_helper.dart';
import 'package:memories/model/place.dart';

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
            location: null,
            image: File( item['image']),
          ),
        )
        .toList();

    notifyListeners();
  }

  void add(String title, File image) {
    final place = Place(
      id: DateTime.now().toIso8601String(),
      title: title,
      image: image,
      location: null,
    );

    _items.add(place);

    notifyListeners();

    var data = <String, Object>{
      'id': place.id,
      'title': place.title,
      'image': place.image.path
    };

    DBHelper.insert('tb_places', data);
  }
}
