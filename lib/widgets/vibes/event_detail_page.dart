import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  final Map<String, dynamic> eventDetails;

  EventDetailPage({required this.eventDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eventDetails['name'], style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventDetails['name'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              eventDetails['venue'],
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              eventDetails['dateTime'],
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // এখানে আপনার টিকিট কেনার লজিক যোগ করুন।
              },
              child: Text('Buy Ticket'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE871C5), // primary এর পরিবর্তে backgroundColor ব্যবহার করুন
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // ওয়েবভিউ পেজ খুলতে এখানে কোড যোগ করুন
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewPage(url: eventDetails['ticketUrl']),
                  ),
                );
              },
              child: Text('Visit Event Website'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE871C5), // primary এর পরিবর্তে backgroundColor ব্যবহার করুন
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF121212),
    );
  }
}

class WebViewPage extends StatelessWidget {
  final String url;

  WebViewPage({required this.url});

  @override
  Widget build(BuildContext context) {
    // এখানে আপনার ওয়েবভিউ ইমপ্লিমেন্টেশন যোগ করুন
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Website', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'WebView Content',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Color(0xFF121212),
    );
  }
}
