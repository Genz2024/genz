import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String userName;
  final String userId;

  EditProfilePage({required this.userName, required this.userId});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userName;
    _userIdController.text = widget.userId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _userIdController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    Navigator.pop(context, {
      'name': _nameController.text,
      'userId': _userIdController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _userIdController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Gen-Z ID',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE871C5),
                ),
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
