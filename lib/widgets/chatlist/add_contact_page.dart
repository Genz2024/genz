import 'package:flutter/material.dart';
import '../me/qr_code_page.dart'; // সঠিক পাথ ব্যবহার করা হয়েছে

class AddContactPage extends StatefulWidget {
  final String userId; // userId প্যারামিটার যোগ করা হলো

  AddContactPage({required this.userId}); // কনস্ট্রাক্টর ঠিক করা হলো

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  String searchedGenZID = '';

  // এখানে সার্চ করা ব্যবহারকারীর তথ্য রাখার জন্য একটি ডেমো ডাটা লিস্ট
  final List<Map<String, String>> dummyData = [
    {'genzID': 'GenZ-1234', 'number': '0123456789'},
    {'genzID': 'GenZ-5678', 'number': '9876543210'},
  ];

  List<Map<String, String>> searchResults = [];

  void searchContact(String query) {
    setState(() {
      isSearching = true;
      searchResults = dummyData
          .where((user) =>
              user['genzID']!.contains(query) || user['number']!.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black, // ব্যাকগ্রাউন্ড কালার কালো করা হয়েছে
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white24, // ইনপুট ফিল্ডের ব্যাকগ্রাউন্ড কালো করে হালকা করা
                prefixIcon: Icon(Icons.search, color: Colors.white), // সার্চ আইকন যুক্ত করা হয়েছে
                hintText: 'Gen-Z ID/Account Number', // টেক্সট দেওয়া হয়েছে
                hintStyle: TextStyle(color: Colors.white60), // হিন্ট টেক্সটের রং সাদা
              ),
              style: TextStyle(color: Colors.white), // ইনপুট টেক্সটের রং সাদা
              onChanged: (value) {
                if (value.isNotEmpty) {
                  searchContact(value);
                } else {
                  setState(() {
                    isSearching = false;
                    searchResults.clear();
                  });
                }
              },
            ),
            SizedBox(height: 20),
            // My Gen-Z ID section below the bar with QR Code icon
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Gen-Z ID: ${widget.userId}', // Gen-Z ID দেখানো হচ্ছে
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  IconButton( // QR কোড আইকন ডান পাশে যোগ করা হয়েছে
                    icon: Icon(Icons.qr_code, color: Colors.white70),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QRCodePage()), 
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            isSearching
                ? Expanded(
                    child: ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            searchResults[index]['genzID']!,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          subtitle: Text(
                            searchResults[index]['number']!,
                            style: TextStyle(color: Colors.grey),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.qr_code, color: Colors.white),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('QR code for ${searchResults[index]['genzID']}'),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )
                : Container(), // কোনো ফলাফল না থাকলে কিছু দেখাবে না
          ],
        ),
      ),
    );
  }
}
