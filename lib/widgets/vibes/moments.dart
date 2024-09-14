import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'moment_card.dart';

class MomentsPage extends StatefulWidget {
  @override
  _MomentsPageState createState() => _MomentsPageState();
}

class _MomentsPageState extends State<MomentsPage> {
  File? _selectedImage;
  final TextEditingController _captionController = TextEditingController();

  final List<Map<String, dynamic>> moments = [
    {
      'imageUrl': 'lib/assets/images/profile0.jpg',
      'caption': 'Enjoying the sunset!',
      'likes': 120,
      'comments': 30,
      'username': 'Tomioka Giyuu',
      'profilePic': 'lib/assets/images/profile0.jpg',
      'uploadTime': DateTime.now().subtract(Duration(minutes: 5)),
      'isOwner': false,
    },
    {
      'imageUrl': 'lib/assets/images/profile1.jpg',
      'caption': 'A wonderful day at the beach.',
      'likes': 200,
      'comments': 45,
      'username': 'Shinobu Kocho',
      'profilePic': 'lib/assets/images/profile1.jpg',
      'uploadTime': DateTime.now().subtract(Duration(hours: 2)),
      'isOwner': true,
    },
    {
      'imageUrl': 'lib/assets/images/profile2.jpg',
      'caption': 'Exploring the mountains!',
      'likes': 350,
      'comments': 60,
      'username': 'Zenitsu Agatsuma',
      'profilePic': 'lib/assets/images/profile2.jpg',
      'uploadTime': DateTime.now().subtract(Duration(days: 1)),
      'isOwner': false,
    },
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      }
    });
  }

  void _uploadMoment() {
    if (_selectedImage != null && _captionController.text.isNotEmpty) {
      setState(() {
        moments.add({
          'imageUrl': _selectedImage!.path,
          'caption': _captionController.text,
          'likes': 0,
          'comments': 0,
          'username': 'Your Username',
          'profilePic': 'lib/assets/images/profile0.jpg',
          'uploadTime': DateTime.now(),
          'isOwner': true,
        });

        _selectedImage = null;
        _captionController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Moment uploaded successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'Moments',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Upload Moment') {
                _pickImage().then((_) {
                  if (_selectedImage != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CaptionPage(
                          imageFile: _selectedImage!,
                          onUpload: _uploadMoment,
                          captionController: _captionController,
                        ),
                      ),
                    );
                  }
                });
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Upload Moment',
                child: Text('Upload Moment'),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: moments.length,
        itemBuilder: (context, index) {
          return MomentCard(
            imageUrl: moments[index]['imageUrl'],
            caption: moments[index]['caption'],
            likes: moments[index]['likes'],
            comments: moments[index]['comments'],
            username: moments[index]['username'],
            profilePic: moments[index]['profilePic'],
            uploadTime: moments[index]['uploadTime'],
            isOwner: moments[index]['isOwner'],
          );
        },
      ),
    );
  }
}

class CaptionPage extends StatelessWidget {
  final File imageFile;
  final TextEditingController captionController;
  final VoidCallback onUpload;

  CaptionPage({
    required this.imageFile,
    required this.onUpload,
    required this.captionController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write Caption'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(imageFile, width: 200, height: 200),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: captionController,
              decoration: InputDecoration(
                hintText: 'Write a caption...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              onUpload();
              Navigator.pop(context);
            },
            child: Text('Upload Moment'),
          ),
        ],
      ),
    );
  }
}
