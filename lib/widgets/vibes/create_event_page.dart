import 'package:flutter/material.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  void _createEvent() {
    // ইভেন্ট তৈরি করার লজিক এখানে লিখতে হবে
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventConfirmationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Event Name',
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _venueController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Venue',
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _dateTimeController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Date & Time',
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _websiteController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Event Website',
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createEvent,
              child: Text('Create Event'),
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

class EventConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Created', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Event Successfully Created!',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);  // Go back to the create event page
              },
              child: Text('Go Back'),
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
