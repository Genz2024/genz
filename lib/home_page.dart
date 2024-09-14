import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/images/homes.png',
              fit: BoxFit.cover,
            ),
          ),
          // Centered Gen-Z Text with Neon Effect
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Gen-', // 'Gen' part
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White color
                      shadows: [
                        Shadow(
                          offset: Offset(4.0, 4.0),
                          blurRadius: 10.0,
                          color: Colors.lightBlueAccent, // Sky blue shadow
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Z', // 'Z' part without animation
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White color
                      shadows: [
                        Shadow(
                          offset: Offset(4.0, 4.0),
                          blurRadius: 10.0,
                          color: Colors.lightBlueAccent, // Sky blue shadow
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Login and Sign Up Text with More Gap
          Positioned(
            bottom: 50, // Positioned near the bottom
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Increased gap between texts
              children: [
                // Login Text
                Padding(
                  padding: const EdgeInsets.only(left: 50.0), // Login more left
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login'); // Navigates to login_page.dart
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White color
                        shadows: [
                          Shadow(
                            color: Colors.lightBlueAccent,
                            blurRadius: 20,
                          ),
                          Shadow(
                            color: Colors.lightBlueAccent,
                            blurRadius: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Sign Up Text
                Padding(
                  padding: const EdgeInsets.only(right: 50.0), // Sign up more right
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup'); // Navigates to signup_page.dart
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White color
                        shadows: [
                          Shadow(
                            color: Colors.lightBlueAccent,
                            blurRadius: 20,
                          ),
                          Shadow(
                            color: Colors.lightBlueAccent,
                            blurRadius: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
