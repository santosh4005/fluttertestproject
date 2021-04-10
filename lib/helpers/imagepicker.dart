import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final String imageUrl;
  final Function(File pickerImage) imagePickFn;

  ImagePickerWidget({required this.imageUrl, required this.imagePickFn});

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  late File _image;
  final imagePicker = ImagePicker();

  void _pickImage() async {
    final pickedFile = await imagePicker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      widget.imagePickFn(_image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey,
            backgroundImage: FileImage(_image)),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: Icon(
            Icons.image,
            color: Colors.white,
          ),
          label: Text(
            "Add Image",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
