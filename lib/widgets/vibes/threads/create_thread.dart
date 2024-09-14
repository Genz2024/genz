import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateThreadPage extends StatefulWidget {
  final String? initialTitle;
  final String? initialDescription;
  final String? initialImageUrl;

  CreateThreadPage({this.initialTitle, this.initialDescription, this.initialImageUrl});

  @override
  _CreateThreadPageState createState() => _CreateThreadPageState();
}

class _CreateThreadPageState extends State<CreateThreadPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image; // Image file variable
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle ?? '';
    _descriptionController.text = widget.initialDescription ?? '';
    if (widget.initialImageUrl != null) {
      _image = File(widget.initialImageUrl!);
    }
  }

  void _sendThread() {
    if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
      Navigator.pop(context, {
        'username': 'CurrentUser', // এখানে আপনার অ্যাপ্লিকেশনের বাস্তব ইউজারের নাম যুক্ত করতে হবে
        'profilePic': 'lib/assets/images/default.jpg', // এখানে ইউজারের প্রোফাইল পিকচার যুক্ত করতে হবে
        'title': _titleController.text,
        'description': _descriptionController.text,
        'comments': 0,
        'likes': 0,
        'imageUrl': _image?.path,
        'isOwnPost': true, // ইউজারের নিজস্ব পোস্ট বোঝানোর জন্য এটি ব্যবহার করা হবে
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Thread', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Thread Title',
                labelStyle: TextStyle(color: Colors.grey), // Light grey color for the label
                filled: true,
                fillColor: Color(0xFF1A1A1A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Thread Description',
                labelStyle: TextStyle(color: Colors.grey), // Light grey color for the label
                filled: true,
                fillColor: Color(0xFF1A1A1A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLines: 5,
              onChanged: (value) {
                setState(() {});
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt, color: Color(0xFF9872EB)),
                  onPressed: _takePhoto,
                ),
                IconButton(
                  icon: Icon(Icons.image, color: Color(0xFF9872EB)),
                  onPressed: _pickImage,
                ),
              ],
            ),
            if (_image != null) ...[
              SizedBox(height: 10),
              Stack(
                children: [
                  Image.file(_image!, height: 100),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _image = null;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty)
                    ? _sendThread
                    : null,
                child: Text('Send', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty)
                      ? Color(0xFFE871C5)
                      : Colors.grey, // Inactive state color
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
