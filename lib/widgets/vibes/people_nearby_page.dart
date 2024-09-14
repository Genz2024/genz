import 'package:flutter/material.dart';
import 'package:genz/user_profile_page.dart'; // ইউজার প্রোফাইল পেজ ইমপোর্ট করা হয়েছে

class PeopleNearbyPage extends StatelessWidget {
  final List<Map<String, dynamic>> people = [
    {
      'name': 'Alice Johnson',
      'profilePic': 'lib/assets/images/profile1.jpg',
      'distance': 1.5,
      'status': 'Up for Coffee',
      'bio': 'Coffee lover. Let\'s grab a cup!',
      'study': 'Harvard University',
      'dob': 'January 1, 1995',
      'relationshipStatus': 'Single',
      'cover': 'lib/assets/images/cover1.jpg',
    },
    {
      'name': 'Bob Smith',
      'profilePic': 'lib/assets/images/profile2.jpg',
      'distance': 2.3,
      'status': 'Looking for Friendship',
      'bio': 'Looking to make new friends!',
      'study': 'MIT',
      'dob': 'February 10, 1992',
      'relationshipStatus': 'In a Relationship',
      'cover': 'lib/assets/images/cover2.jpg',
    },
    {
      'name': 'Charlie Brown',
      'profilePic': 'lib/assets/images/profile3.jpg',
      'distance': 0.8,
      'status': 'Up for Hook Up',
      'bio': 'Open-minded and adventurous.',
      'study': 'Stanford University',
      'dob': 'March 15, 1993',
      'relationshipStatus': 'Complicated',
      'cover': 'lib/assets/images/cover3.jpg',
    },
    {
      'name': 'Diana Prince',
      'profilePic': 'lib/assets/images/profile4.jpg',
      'distance': 3.0,
      'status': 'Just Meeting New People',
      'bio': 'Let\'s make new connections!',
      'study': 'Yale University',
      'dob': 'April 20, 1994',
      'relationshipStatus': 'Single',
      'cover': 'lib/assets/images/cover4.jpg',
    },
    {
      'name': 'Eve Torres',
      'profilePic': 'lib/assets/images/profile5.jpg',
      'distance': 5.1,
      'status': 'Up for a Walk',
      'bio': 'Love nature walks.',
      'study': 'Princeton University',
      'dob': 'May 25, 1996',
      'relationshipStatus': 'Single',
      'cover': 'lib/assets/images/cover5.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'People Nearby',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16, // ফন্ট ছোট করা হয়েছে
            ),
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true, // টেক্সট সেন্টারে আনার জন্য
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0), // গ্যাপ কার্ডের মধ্যে
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF9872EB).withOpacity(0.3),
                    offset: Offset(3, 3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Color(0xFFE871C5).withOpacity(0.2),
                    offset: Offset(-3, -3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(people[index]['profilePic']),
                  radius: 28,
                ),
                title: Text(
                  people[index]['name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${people[index]['distance']} km away',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF3A3A3A), // স্ট্যাটাসের ডার্ক গ্রে ব্যাকগ্রাউন্ড
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        people[index]['status'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16, // আইকনের সাইজ ছোট করা হয়েছে
                  ),
                ),
                onTap: () {
                  // এখানে ইউজার প্রোফাইলে নিয়ে যাওয়ার কোড
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfilePage(
                        name: people[index]['name'],
                        bio: people[index]['bio'],
                        study: people[index]['study'],
                        dob: people[index]['dob'],
                        status: people[index]['status'],
                        relationshipStatus: people[index]['relationshipStatus'],
                        image: people[index]['profilePic'],
                        cover: people[index]['cover'],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      backgroundColor: Color(0xFF121212),
    );
  }
}
