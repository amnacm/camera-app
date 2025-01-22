import 'dart:io';

import 'db.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        title: const Text(
          'Gallery',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseFunction.instance.getAllImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text(
              'No images found.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String imagePath = snapshot.data![index]['image_path'];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.file(
                    File(imagePath),
                    height: 362,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
