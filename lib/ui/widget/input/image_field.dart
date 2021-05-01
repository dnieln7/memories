import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageField extends StatefulWidget {
  ImageField({this.theme, this.saveListener});

  final Color theme;
  final Function saveListener;

  @override
  _ImageFieldState createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  File image;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 100,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: widget.theme, width: 1),
          ),
          child: image != null
              ? Image.file(image, fit: BoxFit.fill)
              : Text('No image', textAlign: TextAlign.center),
        ),
        SizedBox(width: 10),
        TextButton.icon(
          icon: Icon(Icons.camera_sharp),
          label: Text('Take picture'),
          onPressed: openCamera,
        ),
      ],
    );
  }

  Future<void> openCamera() async {
    final pickerFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickerFile != null) {
      setState(() => image = File(pickerFile.path));

      final dir = await getApplicationDocumentsDirectory();
      final imageName = basename(image.path);
      final savedImage = await image.copy('${dir.path}/$imageName');

      widget.saveListener(savedImage);
    }
  }
}
