import 'package:flutter/material.dart';
import 'widgets/custom_navbar.dart'; // Import your CustomNavBar

class VibePage extends StatelessWidget {
  final List<Map<String, dynamic>> vibeOptions = [
    {'icon': 'lib/assets/icons/moments.png', 'text': 'Moments', 'route': '/moments'},
    {'icon': 'lib/assets/icons/thread.png', 'text': 'Thread', 'route': '/thread'},
    {'icon': 'lib/assets/icons/vibe.png', 'text': 'Vibes', 'route': '/vibes'},
    {'icon': 'lib/assets/icons/scan.png', 'text': 'Scan', 'route': '/scan'},
    {'icon': 'lib/assets/icons/search.png', 'text': 'Search', 'route': '/search'},
    {'icon': 'lib/assets/icons/zone.png', 'text': 'Zone', 'route': '/zone'},
    {'icon': 'lib/assets/icons/event.png', 'text': 'Event Discovery', 'route': '/event_discovery'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              'Vibe',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: vibeOptions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, vibeOptions[index]['route']);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds),
                              child: Image.asset(
                                vibeOptions[index]['icon'],
                                width: 24,
                                height: 24,
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              vibeOptions[index]['text'],
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds),
                          child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Highlighted Section - "Watch Ad to Donate" & "Play and Earn" at Bottom
          _buildHighlightedSection(context),
        ],
      ),
      bottomNavigationBar: CustomNavBar( // Add the NavBar here
        currentIndex: 2,  // Assuming 'Vibe' is at index 2
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/chatlist');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/fling');
          } else if (index == 2) {
            // Stay on the same page because you're already on the Vibe page.
          } else if (index == 3) {
            Navigator.pushNamed(context, '/profile');
          }
        },
      ),
    );
  }

  // Widget to build highlighted sections at the bottom
  Widget _buildHighlightedSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          // Watch Ad to Donate (Philistine flag)
          GestureDetector(
            onTap: () {
              // Action for Watch Ad to Donate
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.red],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Watch Ad to Donate 🇵🇸', // Philistine flag emoji added
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.favorite, color: Colors.white, size: 30),
                ],
              ),
            ),
          ),
          // Play and Earn
          GestureDetector(
            onTap: () {
              // Action for Play and Earn
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blueAccent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Play and Earn 🎮', // Added Play and Earn text
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.games, color: Colors.white, size: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
