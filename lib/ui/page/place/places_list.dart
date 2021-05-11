import 'package:flutter/material.dart';
import 'package:memories/provider/place_provider.dart';
import 'package:memories/ui/page/place/add_place.dart';
import 'package:memories/ui/page/place/place_detail.dart';
import 'package:provider/provider.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My memories'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_sharp),
            onPressed: () => Navigator.of(context).pushNamed(AddPlace.path),
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<PlaceProvider>(context, listen: false).fetchFromDb(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<PlaceProvider>(
                builder: (ctx, provider, reusable) => provider.places.isEmpty
                    ? reusable
                    : ListView.builder(
                        itemBuilder: (ct, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(provider.places[index].image),
                          ),
                          title: Text(provider.places[index].title),
                          subtitle:
                              Text(provider.places[index].location.address),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  PlaceDetail(provider.places[index]),
                            ),
                          ),
                        ),
                        itemCount: provider.places.length,
                      ),
                child: Center(
                  child: Text('Got not places, start adding some!'),
                ),
              ),
      ),
    );
  }
}
