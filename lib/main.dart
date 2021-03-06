import 'package:flutter/material.dart';
import 'package:memories/provider/place_provider.dart';
import 'package:memories/ui/page/place/add_place.dart';
import 'package:memories/ui/page/place/places_list.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => PlaceProvider(),
      child: MaterialApp(
        title: 'Memories',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesList(),
        routes: {
          AddPlace.path: (ctx) => AddPlace(),
        },
      ),
    );
  }
}
