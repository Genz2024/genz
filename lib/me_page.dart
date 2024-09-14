import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'widgets/custom_navbar.dart';
import 'widgets/me/edit_profile_page.dart';
import 'widgets/me/about_me_page.dart';
import 'widgets/me/pay_services_page.dart';
import 'widgets/me/my_moments_page.dart';
import 'widgets/me/settings_page.dart';
import 'widgets/me/qr_code_page.dart'; // QR কোড পেজ ইম্পোর্ট করা হয়েছে

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  File? _profileImage;
  File? _coverImage;
  String _userName = 'Tomioka Giyuu';
  String _userId = 'Tomioka_Giyuu';
  String? _status; // স্ট্যাটাস সংরক্ষণ করার জন্য

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source, bool isProfile) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 85,
      maxHeight: 480,
      maxWidth: 640,
    );

    if (pickedFile != null && pickedFile.path.endsWith('.jpg')) {
      setState(() {
        if (isProfile) {
          _profileImage = File(pickedFile.path);
        } else {
          _coverImage = File(pickedFile.path);
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select a .jpg image'),
        backgroundColor: Colors.red,
      ));
    }
  }

  void _showProfileOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo, color: Color(0xFFE871C5)),
                title: Text('View Profile Picture', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Color(0xFFE871C5)),
                title: Text('Change Profile Picture', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery, true);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Color(0xFFE871C5)),
                title: Text('Delete Profile Picture', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _profileImage = null;
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

  void _showCoverOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo, color: Color(0xFFE871C5)),
                title: Text('View Cover Picture', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Color(0xFFE871C5)),
                title: Text('Change Cover Picture', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery, false);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Color(0xFFE871C5)),
                title: Text('Delete Cover Picture', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _coverImage = null;
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

  void _showStatusPopup() {
    final _statusController = TextEditingController(text: _status);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'Set Status',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: _statusController,
            maxLength: 50,
            maxLines: 2,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter your status (1-50 words)',
              hintStyle: TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Color(0xFF222222),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Color(0xFFE871C5)),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _status = _statusController.text.trim();
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'Save',
                style: TextStyle(color: Color(0xFFE871C5)),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfilePage(
        userName: _userName,
        userId: _userId,
      )),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        _userName = result['name'] ?? _userName;
        _userId = result['userId'] ?? _userId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              'Me',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: _navigateToEditProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: _showCoverOptions,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _coverImage != null
                            ? FileImage(_coverImage!)
                            : AssetImage('lib/assets/images/cover0.jpg') as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 5,
                  child: GestureDetector(
                    onTap: _showProfileOptions,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : AssetImage('lib/assets/images/profile0.jpg'),
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userName, // User name
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Gen-Z ID: $_userId', // User ID
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      if (_status != null && _status!.isNotEmpty) // যদি স্ট্যাটাস থাকে, তা দেখাবে
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0, left: 0), // স্ট্যাটাস টেক্সট একটু বামে সরানো হয়েছে
                          child: Text(
                            _status!,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // QR কোড আইকনকে পুনরায় স্ট্যাটাস বারের উপরে স্থানান্তরিত করা হয়েছে
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    icon: Icon(Icons.qr_code, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QRCodePage()), // Navigate to QR Code Page
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 100,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: _showStatusPopup,
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(70, 25),
                        minimumSize: Size(20, 5),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        _status != null && _status!.isNotEmpty ? 'Edit Status' : '+Status', // স্ট্যাটাস এডিট বাটন
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildCustomListTile(
              icon: AssetImage('lib/assets/icons/pay_s.png'),
              title: 'Pay and Services',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PayServicesPage()),
                );
              },
            ),
            _buildCustomListTile(
              icon: AssetImage('lib/assets/icons/moments_m.png'),
              title: 'My Moments',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyMomentsPage()),
                );
              },
            ),
            _buildCustomListTile(
              icon: AssetImage('lib/assets/icons/vibes_m.png'),
              title: 'My Vibes',
              onTap: () {
                // My Vibes page navigation
              },
            ),
            _buildCustomListTile(
              icon: AssetImage('lib/assets/icons/thread.png'),
              title: 'My Threads',
              onTap: () {
                // My Threads page navigation
              },
            ),
            _buildCustomListTile(
              icon: AssetImage('lib/assets/icons/about_m.png'),
              title: 'About Me',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutMePage()),
                );
              },
            ),
            _buildCustomListTile(
              icon: AssetImage('lib/assets/icons/settings.png'),
              title: 'Settings',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: CustomNavBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/chatlist');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/fling');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/vibe');
          } else if (index == 3) {
            // Already on the Me page, do nothing
          }
        },
      ),
    );
  }

  Widget _buildCustomListTile({required AssetImage icon, required String title, required Function() onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Material(
        color: Colors.black,
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Image(image: icon, width: 24, height: 24),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds),
                  child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
