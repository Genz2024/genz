import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'greeting_page.dart';
import 'user_profile_page.dart';
import 'package:genz/widgets/custom_navbar.dart';
import 'widgets/fling/nearby_popup.dart'; // Nearby Popup import

class FlingPage extends StatefulWidget {
  @override
  _FlingPageState createState() => _FlingPageState();
}

class _FlingPageState extends State<FlingPage> {
  final List<Map<String, dynamic>> users = [
    {
      'name': 'Tomioka Giyuu',
      'bio': 'Let\'s make some questionable decisions together.',
      'study': 'Nijigata university of technology/NJIT',
      'dob': 'January 20, 2000',
      'status': 'Looking for adventure',
      'relationshipStatus': 'Single',
      'distance': 1.5, 
      'image': 'lib/assets/images/profile0.jpg',
      'cover': 'lib/assets/images/cover0.jpg',
    },
    {
      'name': 'Shinobu Kocho',
      'bio': 'Life is a mystery to unravel, one step at a time.',
      'study': 'Tokyo Metropolitan University',
      'dob': 'March 5, 1999',
      'status': 'Exploring life',
      'relationshipStatus': 'Single',
      'distance': 2.3, 
      'image': 'lib/assets/images/profile1.jpg',
      'cover': 'lib/assets/images/cover1.jpg',
    },
    {
      'name': 'Zenitsu Agatsuma',
      'bio': 'Let\'s run through the storms together.',
      'study': 'Kyoto Institute of Technology',
      'dob': 'April 15, 2001',
      'status': 'Seeking thrill',
      'relationshipStatus': 'Complicated',
      'distance': 0.8, 
      'image': 'lib/assets/images/profile2.jpg',
      'cover': 'lib/assets/images/cover2.jpg',
    },
    {
      'name': 'Tanjiro Kamado',
      'bio': 'Always keep moving forward, no matter what.',
      'study': 'Osaka University',
      'dob': 'July 14, 2001',
      'status': 'On a journey',
      'relationshipStatus': 'In a relationship',
      'distance': 3.0, 
      'image': 'lib/assets/images/profile3.jpg',
      'cover': 'lib/assets/images/cover3.jpg',
    },
    {
      'name': 'Nezuko Kamado',
      'bio': 'In the darkest of times, the light shines brightest.',
      'study': 'University of the Arts London',
      'dob': 'December 28, 2002',
      'status': 'Finding my way',
      'relationshipStatus': 'Single',
      'distance': 5.1, 
      'image': 'lib/assets/images/profile4.jpg',
      'cover': 'lib/assets/images/cover4.jpg',
    },
  ];

  int currentIndex = 0;
  double cardOffsetX = 0;
  double cardOpacity = 1;
  bool showPopup = false; // Nearby পপ-আপ দেখানোর জন্য একটি boolean ফ্ল্যাগ

  void handleTeaAction(bool interested) {
    if (interested) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GreetingPage(
            userName: users[currentIndex]['name']!,
            userImage: users[currentIndex]['image']!,
          ),
        ),
      );
    } else {
      setState(() {
        cardOffsetX = -2000;
        cardOpacity = 0;
      });

      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          cardOffsetX = 0;
          cardOpacity = 1;

          if (currentIndex < users.length - 1) {
            currentIndex++;
          } else {
            currentIndex = 0;
          }
        });
      });
    }
  }

  void showNearbyPopup() {
    setState(() {
      showPopup = !showPopup; // Nearby popup দেখানো হচ্ছে বা বন্ধ হচ্ছে
    });
  }

  void openBluetoothSettings() async {
    final intent = AndroidIntent(
      action: 'android.settings.BLUETOOTH_SETTINGS',
    );
    await intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (showPopup) {
          setState(() {
            showPopup = false; // বাইরে ক্লিক করলে পপ-আপ বন্ধ
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Column(
            children: [
              Center(
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    'Fling',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: openBluetoothSettings,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Turn on ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: openBluetoothSettings,
                        child: Icon(
                          Icons.bluetooth,
                          color: Color(0xFF699BF7),
                          size: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: openBluetoothSettings,
                        child: Text(
                          ' Bluetooth',
                          style: TextStyle(
                            color: Color(0xFF699BF7),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        ' to connect with nearby people',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              left: cardOffsetX,
              top: 130,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: cardOpacity,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfilePage(
                          name: users[currentIndex]['name'] ?? 'Unknown',
                          bio: users[currentIndex]['bio'] ?? '',
                          study: users[currentIndex]['study'] ?? '',
                          dob: users[currentIndex]['dob'] ?? 'Not Provided',
                          status: users[currentIndex]['status'] ?? 'No Status',
                          relationshipStatus: users[currentIndex]['relationshipStatus'] ?? 'Unknown',
                          image: users[currentIndex]['image']!,
                          cover: users[currentIndex]['cover']!,
                        ),
                      ),
                    );
                  },
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity! > 0) {
                      handleTeaAction(true);
                    } else if (details.primaryVelocity! < 0) {
                      handleTeaAction(false);
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.black,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 2,
                          color: Colors.transparent,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF9872EB).withOpacity(0.5),
                            offset: Offset(-2, -2),
                            blurRadius: 5,
                          ),
                          BoxShadow(
                            color: Color(0xFFE871C5).withOpacity(0.5),
                            offset: Offset(2, 2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    users[currentIndex]['cover']!,
                                    height: 130,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 70,
                                  left: 3,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(users[currentIndex]['image']!),
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                Positioned(
                                  top: 80,
                                  left: 70,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        users[currentIndex]['name']!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          users[currentIndex]['status']!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 110, 
                                  right: 10, 
                                  child: Text(
                                    '${users[currentIndex]['distance'] ?? 0.0} km away', 
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'BIO: ${users[currentIndex]['bio']!}',
                                  style: TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Study: ${users[currentIndex]['study']!}',
                                  style: TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () => handleTeaAction(false),
                                  child: Image.asset(
                                    'lib/assets/icons/notea.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => handleTeaAction(true),
                                  child: Image.asset(
                                    'lib/assets/icons/tea.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
           if (showPopup) NearbyPopup(
             nearbyUsers: users, // এখানে একাধিক ব্যবহারকারী থাকবে
             onGreet: () => handleTeaAction(true), // Greeting ফাংশন কল
           ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: showNearbyPopup, // Nearby পপ-আপ দেখার জন্য ম্যানুয়ালি কল
          child: Icon(Icons.person),
          backgroundColor: Color(0xFFE871C5),
        ),
        bottomNavigationBar: CustomNavBar(
          currentIndex: 1,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/chatlist');
                break;
              case 1:
                Navigator.pushNamed(context, '/fling');
                break;
              case 2:
                // Add other page navigations here
                break;
              case 3:
                // Add other page navigations here
                break;
            }
          },
        ),
      ),
    );
  }
}
