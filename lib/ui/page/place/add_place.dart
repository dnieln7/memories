import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memories/provider/place_provider.dart';
import 'package:memories/ui/widget/input/image_field.dart';
import 'package:memories/ui/widget/input/text_field_empty.dart';
import 'package:provider/provider.dart';

class AddPlace extends StatefulWidget {
  static const String path = '/places/add';

  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool working = false;
  String title;
  File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text('Add a new place')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFieldEmpty(
                    hint: 'Title',
                    theme: Theme.of(context).primaryColor,
                    inputAction: TextInputAction.next,
                    changeListener: (text) => title = text,
                    validator: (text) => text.toString().isEmpty
                        ? 'This field is required'
                        : null,
                  ),
                  SizedBox(height: 20),
                  ImageField(
                    theme: Theme.of(context).primaryColor,
                    saveListener: (image) => selectImage(image),
                  ),
                ],
              ),
            ),
            if (!working)
              ElevatedButton.icon(
                icon: Icon(Icons.add_sharp),
                label: Text('Add place'),
                onPressed: savePlace,
                // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // remove default margin of elevation
              ),
            if (working)
              Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  void selectImage(File image) {
    this.image = image;
  }

  void savePlace() {
    setState(() => working = true);

    if (formKey.currentState.validate() && image != null) {
      Provider.of<PlaceProvider>(context, listen: false).add(title, image);
      Navigator.of(context).pop();
      setState(() => working = false);
    } else {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('You need to add an image'),
          duration: Duration(seconds: 1),
        ),
      );
      setState(() => working = false);
    }
  }
}
