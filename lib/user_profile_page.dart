import 'package:flutter/material.dart';
import 'greeting_page.dart';

class UserProfilePage extends StatelessWidget {
  final String name;
  final String bio;
  final String study;
  final String dob;
  final String status;
  final String relationshipStatus;
  final String image;
  final String cover;

  UserProfilePage({
    required this.name,
    required this.bio,
    required this.study,
    required this.dob,
    required this.status,
    required this.relationshipStatus,
    required this.image,
    required this.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$name\'s Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Block') {
                // ব্যবহারকারীকে ব্লক করার লজিক এখানে বসানো হবে
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Block', 'Remove Greeting'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Image.asset(
                  cover,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 120,
                  left: 5,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(image),
                    radius: 40,
                  ),
                ),
                Positioned(
                  top: 150, // নামের অবস্থান উপরে সরানো হয়েছে
                  left: 90, // নামের অবস্থান বামে সরানো হয়েছে
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18, // ফন্টের আকার ছোট করা হয়েছে
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BIO',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    bio,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Study',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    study,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Date of Birth',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    dob,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'What\'s up',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    status,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Relationship Status',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    relationshipStatus,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // Moments পেজে নেভিগেট করার লজিক
                    },
                    child: Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Text(
                            'Moments',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Spacer(),
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // Threads পেজে নেভিগেট করার লজিক
                    },
                    child: Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Text(
                            'Threads',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Spacer(),
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // Vibes পেজে নেভিগেট করার লজিক
                    },
                    child: Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Text(
                            'Vibes',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Spacer(),
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GreetingPage(
                              userName: name,
                              userImage: image,
                            ),
                          ),
                        );
                      },
                      child: Text('Send Greeting'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE871C5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
