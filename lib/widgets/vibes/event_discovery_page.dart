import 'package:flutter/material.dart';
import 'create_event_page.dart'; // Create Event Page import

class EventDiscoveryPage extends StatelessWidget {
  final List<Map<String, dynamic>> trendingEvents = [
    {
      'name': 'Global Music Fest',
      'venue': 'Ocean Arena',
      'time': 'Ongoing',
      'website': 'https://example.com/tickets',
    },
    {
      'name': 'Tech Summit 2024',
      'venue': 'Tech Park',
      'time': 'Next Week, 9:00 AM',
      'website': 'https://example.com/tickets',
    },
  ];

  final List<Map<String, dynamic>> ongoingEvents = [
    {
      'name': 'Art & Culture Expo',
      'venue': 'City Museum',
      'time': 'Ongoing',
      'website': 'https://example.com/tickets',
    },
    {
      'name': 'Charity Run 2024',
      'venue': 'Downtown Streets',
      'time': 'Today, 6:00 PM',
      'website': 'https://example.com/tickets',
    },
  ];

  final List<Map<String, dynamic>> upcomingEvents = [
    {
      'name': 'Food Carnival',
      'venue': 'Town Plaza',
      'time': 'Tomorrow, 3:00 PM',
      'website': 'https://example.com/tickets',
    },
    {
      'name': 'Startup Weekend',
      'venue': 'Innovation Hub',
      'time': 'Next Month, 10:00 AM',
      'website': 'https://example.com/tickets',
    },
  ];

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
              'Event Discovery',
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
            icon: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Icon(Icons.add, color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateEventPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Trending Events'),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: trendingEvents.length,
                itemBuilder: (context, index) {
                  return _buildTrendingEventCard(trendingEvents[index]);
                },
              ),
              SizedBox(height: 20),
              _buildSectionTitle('Ongoing Events'),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: ongoingEvents.length,
                itemBuilder: (context, index) {
                  return _buildEventCard(ongoingEvents[index]);
                },
              ),
              SizedBox(height: 20),
              _buildSectionTitle('Upcoming Events'),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: upcomingEvents.length,
                itemBuilder: (context, index) {
                  return _buildEventCard(upcomingEvents[index]);
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black, // ব্যাকগ্রাউন্ড কালো করা হয়েছে
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTrendingEventCard(Map<String, dynamic> event) {
    return Card(
      color: Color(0xFF2B2B2B),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.local_fire_department, color: Colors.redAccent, size: 30),
                SizedBox(width: 10),
                Text(
                  event['name'],
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              '${event['venue']} - ${event['time']}',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _launchURL(event['website']);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE871C5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Center(
                child: Text('Get Tickets', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Card(
      color: Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          event['name'],
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          '${event['venue']} - ${event['time']}',
          style: TextStyle(color: Colors.white70),
        ),
        trailing: ElevatedButton(
          onPressed: () {
            _launchURL(event['website']);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFE871C5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text('Get Tickets', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  void _launchURL(String url) {
    // URL launch logic here, using url_launcher package
    print("Launching URL: $url");
  }
}
