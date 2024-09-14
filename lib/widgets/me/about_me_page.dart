import 'package:flutter/material.dart';

class AboutMePage extends StatefulWidget {
  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _studyController = TextEditingController();
  final TextEditingController _workAtController = TextEditingController();
  final TextEditingController _workPositionController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String _relationshipStatus = 'Single'; // Default status
  String _gender = 'Male'; // Default gender

  @override
  void initState() {
    super.initState();
    // এখানে ব্যবহারকারীর প্রোফাইলের তথ্য প্রি-ফিল করতে পারবেন
    _bioController.text = 'Let\'s make some questionable decisions together.';
    _studyController.text = 'Nijigata University of Technology/NJIT';
    _workAtController.text = 'Some Company'; // Work At
    _workPositionController.text = 'Software Engineer'; // Work Position
    _religionController.text = 'Islam'; // Religion
    _languageController.text = 'English'; // Language
    _dobController.text = '1999-12-25'; // প্রি-ফিল করা ডেট অফ বার্থ
  }

  void _showRelationshipStatusPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black,
          child: ListView(
            children: [
              ListTile(
                title: Text('Single', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _relationshipStatus = 'Single';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Married', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _relationshipStatus = 'Married';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('In a Relationship', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _relationshipStatus = 'In a Relationship';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Astagfiruallah', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _relationshipStatus = 'Astagfiruallah';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('It’s Haram Bro', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _relationshipStatus = 'It’s Haram Bro';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showGenderPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black,
          child: ListView(
            children: [
              ListTile(
                title: Text('Male', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _gender = 'Male';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Female', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _gender = 'Female';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Other', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _gender = 'Other';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Me', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _bioController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Bio',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _studyController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Study (University/College/School)',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: _showRelationshipStatusPicker,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Relationship Status',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _relationshipStatus,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: _showGenderPicker,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _gender,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _dobController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _workAtController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Works At',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _workPositionController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Work Position',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _religionController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Religion',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _languageController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Language',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save About Me details logic here
                  Navigator.pop(context);
                },
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
