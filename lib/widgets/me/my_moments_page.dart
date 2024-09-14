import 'package:flutter/material.dart';
import 'dart:io'; // For handling file operations
import 'package:image_picker/image_picker.dart'; // For picking images

class MyMomentsPage extends StatefulWidget {
  @override
  _MyMomentsPageState createState() => _MyMomentsPageState();
}

class _MyMomentsPageState extends State<MyMomentsPage> {
  List<Map<String, dynamic>> moments = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxHeight: 1080,
      maxWidth: 1080,
    );

    if (pickedFile != null && pickedFile.path.endsWith('.jpg')) {
      setState(() {
        moments.add({
          'image': File(pickedFile.path),
          'date': DateTime.now(),
          'likes': 0,
          'comments': 0,
          'shares': 0,
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select a .jpg image'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Widget _buildMomentCard(Map<String, dynamic> moment) {
    return Card(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(moment['image'], fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${moment['date'].day} ${moment['date'].month}',
                  style: TextStyle(color: Colors.white70),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up, color: Colors.white70),
                      onPressed: () {
                        setState(() {
                          moment['likes']++;
                        });
                      },
                    ),
                    Text('${moment['likes']}', style: TextStyle(color: Colors.white70)),
                    IconButton(
                      icon: Icon(Icons.comment, color: Colors.white70),
                      onPressed: () {
                        setState(() {
                          moment['comments']++;
                        });
                      },
                    ),
                    Text('${moment['comments']}', style: TextStyle(color: Colors.white70)),
                    IconButton(
                      icon: Icon(Icons.share, color: Colors.white70),
                      onPressed: () {
                        setState(() {
                          moment['shares']++;
                        });
                      },
                    ),
                    Text('${moment['shares']}', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Moments', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.add_a_photo, color: Colors.white),
            onPressed: _pickImage,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: moments.map((moment) => _buildMomentCard(moment)).toList(),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
