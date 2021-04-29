import 'package:flutter/foundation.dart';
import 'package:memories/model/place.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get places => [..._items];
}
