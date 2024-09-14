import 'package:flutter/material.dart';

class NearbyPopup extends StatelessWidget {
  final List<Map<String, dynamic>> nearbyUsers; // অনেক ব্যবহারকারীর তথ্য
  final Function onGreet; // গ্রীটিং ফাংশন

  const NearbyPopup({required this.nearbyUsers, required this.onGreet});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50, // বক্সটিকে উপরে সরানো হয়েছে
      left: 10,
      right: 10,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(10), // বক্সের আকার ছোট করা হয়েছে
          height: 120, // উচ্চতা আরও ছোট করা হয়েছে
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [ // নিওফার্মিক শ্যাডো যোগ করা হয়েছে
              BoxShadow(
                color: Color(0xFF9872EB).withOpacity(0.2),
                offset: Offset(-5, -5),
                blurRadius: 8,
              ),
              BoxShadow(
                color: Color(0xFFE871C5).withOpacity(0.5),
                offset: Offset(5, 5),
                blurRadius: 12,
              ),
            ],
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // স্ক্রলিং হরিজন্টাল
            itemCount: nearbyUsers.length, // ব্যবহারকারীর সংখ্যা
            itemBuilder: (context, index) {
              final user = nearbyUsers[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(user['image']),
                      radius: 25, // প্রোফাইলের আকার একটু ছোট করা হয়েছে
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14, // টেক্সটের আকার ছোট করা হয়েছে
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'is nearby!',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12, // টেক্সটের আকার আরও ছোট করা হয়েছে
                          ),
                        ),
                        SizedBox(height: 5),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black, // গ্রীট বাটনের ব্যাকগ্রাউন্ড কালো
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ).copyWith( // নিওফার্মিক শ্যাডো
                            shadowColor: MaterialStateProperty.all(
                              Color(0xFF9872EB).withOpacity(0.5),
                            ),
                            side: MaterialStateProperty.all(
                              BorderSide(
                                color: Colors.black12,
                                width: 2,
                              ),
                            ),
                          ),
                          onPressed: () {
                            onGreet(); // গ্রীটিং ফাংশন কল করা হচ্ছে
                          },
                          child: Text('Greet', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
