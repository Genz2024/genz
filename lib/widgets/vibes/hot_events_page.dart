import 'package:flutter/material.dart';

class HotEventsPage extends StatelessWidget {
  final List<Map<String, dynamic>> hotEvents = [
    {
      'name': 'Fashion Show',
      'venue': 'Elite Hotel',
      'date': '25th Oct, 6:00 PM',
    },
    {
      'name': 'Startup Pitch',
      'venue': 'Innovation Hub',
      'date': '28th Oct, 11:00 AM',
    },
    // Add more events here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hot Events', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: hotEvents.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(hotEvents[index]['name'], style: TextStyle(color: Colors.white)),
            subtitle: Text('${hotEvents[index]['venue']} - ${hotEvents[index]['date']}', style: TextStyle(color: Colors.white70)),
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
