import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My memories'),
        actions: [IconButton(icon: Icon(Icons.add_sharp), onPressed: () => {})],
      ),
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
