import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:testtodelete/helpers/imagepicker.dart';

class ShowImageStuff extends StatefulWidget {
  @override
  _ShowImageStuffState createState() => _ShowImageStuffState();
}

class _ShowImageStuffState extends State<ShowImageStuff> {
  late File _inventoryImageFile;
  String _imageText = DateTime.now().toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Img to Firebase"),
        actions: <Widget>[],
      ),
      body: Center(
        child: Column(
          children: [
            ImagePickerWidget(
              imagePickFn: _pickImage,
              imageUrl: "",
            ),
            Text(_imageText),
            ElevatedButton(
                onPressed: _uploadImage, child: Text("Upload To Firebase"))
          ],
        ),
      ),
    );
  }

  void _pickImage(File pickedImage) {
    _inventoryImageFile = pickedImage;
  }

  void _uploadImage() async {
    if (_inventoryImageFile != null) {
      var imgref = FirebaseStorage.instance
          .ref()
          .child('test_images')
          .child(DateTime.now().toString() + '.jpg');
      await imgref.putFile(_inventoryImageFile).whenComplete(() {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Image Uploaded")));
      });

      var dingleberry = await imgref.getDownloadURL();
      setState(() {
        _imageText = dingleberry;
      });
    }
  }
}
