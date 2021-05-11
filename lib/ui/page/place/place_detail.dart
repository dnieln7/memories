import 'package:flutter/material.dart';
import 'package:memories/model/place.dart';
import 'package:memories/ui/page/map/map_view.dart';

class PlaceDetail extends StatelessWidget {
  PlaceDetail(this._place);

  final Place _place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_place.title)),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              _place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _place.location.address,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (ctx) => MapView(
                          initLocation: _place.location,
                          readOnly: true,
                        ),
                      ),
                    ),
                    child: Text('VIEW ON MAP'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
