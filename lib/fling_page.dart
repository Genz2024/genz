import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'greeting_page.dart';
import 'user_profile_page.dart';
import 'package:genz/widgets/custom_navbar.dart';
import 'widgets/fling/nearby_popup.dart';
import 'widgets/fling/subscription_modal.dart';

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
      'workAt': 'Some Company',
      'workPosition': 'Software Engineer',
      'religion': 'Islam',
      'language': 'English',
      'gender': 'Male',
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
      'workAt': 'Another Company',
      'workPosition': 'Biochemist',
      'religion': 'Shinto',
      'language': 'Japanese',
      'gender': 'Female',
    },
    // অন্যান্য ব্যবহারকারীদের তথ্য...
  ];

  int currentIndex = 0;
  double cardOffsetX = 0;
  double cardOpacity = 1;
  bool showPopup = false;
  int swipeCount = 0; // স্লাইড কাউন্ট
  int greetCount = 0; // গ্রীট কাউন্ট

  void handleTeaAction(bool interested) {
    if (interested) {
      greetCount++; // গ্রীট কাউন্ট বাড়ানো
      if (greetCount >= 5) {
        showSubscriptionModal(context); // ৫ বার গ্রীট পাঠালে সাবস্ক্রিপশন মডেল শো হবে
        greetCount = 0; // কাউন্ট রিসেট
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GreetingPage(
              userName: users[currentIndex]['name']!,
              userImage: users[currentIndex]['image']!,
            ),
          ),
        );
      }
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

          swipeCount++; // স্লাইড কাউন্ট বাড়ানো
          if (swipeCount >= 5) {
            showSubscriptionModal(context); // ৫ বার স্লাইড করলে সাবস্ক্রিপশন মডেল শো হবে
            swipeCount = 0; // কাউন্ট রিসেট
          }
        });
      });
    }
  }

  void showNearbyPopup() {
    showSubscriptionModal(context); // সাবস্ক্রিপশন মডেল শো হবে 'Nearby People' বক্সে ক্লিক করলে
  }

  void openBluetoothSettings() async {
    final intent = AndroidIntent(
      action: 'android.settings.BLUETOOTH_SETTINGS',
    );
    await intent.launch();
  }

  void handleBluetoothOrNearbyClick() {
    showSubscriptionModal(context); // ব্লুটুথ আইকন বা কাছে থাকা লোকদের ক্লিক করলে সাবস্ক্রিপশন মডেল শো হবে
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (showPopup) {
          setState(() {
            showPopup = false;
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
                onTap: handleBluetoothOrNearbyClick, // ব্লুটুথ আইকনে ক্লিক করলে সাবস্ক্রিপশন মডেল শো হবে
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
                        onTap: handleBluetoothOrNearbyClick, // ব্লুটুথ আইকন ক্লিক হ্যান্ডলিং
                        child: Icon(
                          Icons.bluetooth,
                          color: Color(0xFF699BF7),
                          size: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: handleBluetoothOrNearbyClick, // টেক্সট ক্লিক হ্যান্ডলিং
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
                          workAt: users[currentIndex]['workAt'] ?? '',
                          workPosition: users[currentIndex]['workPosition'] ?? '',
                          religion: users[currentIndex]['religion'] ?? '',
                          language: users[currentIndex]['language'] ?? '',
                          gender: users[currentIndex]['gender'] ?? '',
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
            if (showPopup)
              NearbyPopup(
                nearbyUsers: users,
                onGreet: () => handleTeaAction(true),
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: showNearbyPopup, // Nearby পপ-আপ ক্লিক করলে সাবস্ক্রিপশন মডেল শো হবে
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
