import 'package:flutter/material.dart';

class ThreadViewPage extends StatelessWidget {
  final List<Map<String, dynamic>> threads = [
    {
      'title': 'The Future of Technology',
      'content': 'What are your thoughts on the advancements in AI?',
      'author': 'John Doe',
      'time': '2h ago',
    },
    {
      'title': 'Healthy Living Tips',
      'content': 'Share your tips on maintaining a healthy lifestyle.',
      'author': 'Jane Smith',
      'time': '5h ago',
    },
    // আরও থ্রেড যুক্ত করতে পারেন এখানে
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'Threads',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: threads.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // এখানে আপনি যা করতে চান তা যুক্ত করুন।
              print('Thread tapped: ${threads[index]['title']}');
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(5, 5),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.grey[800]!,
                    offset: Offset(-5, -5),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    threads[index]['title'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    threads[index]['content'],
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'by ${threads[index]['author']}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        threads[index]['time'],
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
