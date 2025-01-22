import 'dart:io';

import 'db.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _takePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });

      // Save image path to database
      await DatabaseFunction.instance.insertImage(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 45),
        child: AppBar(
          backgroundColor: Colors.greenAccent,
          centerTitle: true,
          title: const Text(
            'Take a Picture',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image != null
                  ? Image.file(_image!) // Display the taken image
                  : const Text(
                      'No image captured.',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
              ElevatedButton(
                onPressed: _takePicture,
                child: const Text(
                  'Capture Image',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
