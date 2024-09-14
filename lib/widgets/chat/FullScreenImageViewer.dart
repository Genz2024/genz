import 'package:flutter/material.dart';
import 'dart:io';

class FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;

  FullScreenImageViewer({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: imageUrl,
            child: Image.file(
              File(imageUrl),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
