import 'package:flutter/material.dart';

class TrendingEventsPage extends StatelessWidget {
  final List<Map<String, dynamic>> trendingEvents = [
    {
      'name': 'Music Concert',
      'venue': 'Downtown Arena',
      'date': '20th Oct, 7:00 PM',
    },
    {
      'name': 'Tech Conference',
      'venue': 'City Convention Center',
      'date': '22nd Oct, 10:00 AM',
    },
    // Add more events here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Events', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: trendingEvents.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(trendingEvents[index]['name'], style: TextStyle(color: Colors.white)),
            subtitle: Text('${trendingEvents[index]['venue']} - ${trendingEvents[index]['date']}', style: TextStyle(color: Colors.white70)),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white70),
            onTap: () {
              // Go to event detail page
            },
          );
        },
      ),
      backgroundColor: Color(0xFF121212),
    );
  }
}
