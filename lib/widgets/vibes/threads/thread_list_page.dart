import 'package:flutter/material.dart';
import 'comment_page.dart'; // Import CommentPage
import 'create_thread.dart'; // Import CreateThreadPage

class ThreadListPage extends StatefulWidget {
  @override
  _ThreadListPageState createState() => _ThreadListPageState();
}

class _ThreadListPageState extends State<ThreadListPage> {
  List<Map<String, dynamic>> threads = [
    {
      'username': 'User1',
      'profilePic': 'lib/assets/images/profile0.jpg',
      'title': 'What\'s the best programming language?',
      'description': 'Let\'s discuss which programming language is the best for beginners.',
      'comments': 25,
      'likes': 150,
      'imageUrl': null,
      'isOwnPost': true, // This will help identify if it's the user's own post
    },
    {
      'username': 'User2',
      'profilePic': 'lib/assets/images/profile1.jpg',
      'title': 'Flutter vs React Native',
      'description': 'Which framework do you prefer for mobile app development?',
      'comments': 40,
      'likes': 230,
      'imageUrl': 'lib/assets/images/flutter_vs_react_native.jpg',
      'isOwnPost': false,
    },
    {
      'username': 'User3',
      'profilePic': 'lib/assets/images/profile2.jpg',
      'title': 'Best practices in UI design',
      'description': 'Share your tips and tricks for creating stunning user interfaces.',
      'comments': 15,
      'likes': 100,
      'imageUrl': null,
      'isOwnPost': false,
    },
    {
      'username': 'User4',
      'profilePic': 'lib/assets/images/profile3.jpg',
      'title': 'Your favorite tech stack?',
      'description': 'Which technologies do you love working with the most?',
      'comments': 18,
      'likes': 90,
      'imageUrl': 'lib/assets/images/tech_stack.jpg',
      'isOwnPost': false,
    },
  ];

  void showCommentPage(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentPage(
          imageUrl: threads[index]['imageUrl'] ?? '',
          caption: threads[index]['description'] ?? '',
          likes: threads[index]['likes'] ?? 0,
          comments: [],
          onCommentAdded: (newCount) {
            setState(() {
              threads[index]['comments'] = newCount;
            });
          },
        ),
      ),
    );
  }

  void _navigateToCreateThread(BuildContext context) async {
    final newThread = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (context) => CreateThreadPage()),
    );

    if (newThread != null) {
      setState(() {
        threads.insert(0, newThread); // New thread added to the top of the list
      });
    }
  }

  void _updateLikes(int index, int newLikes) {
    setState(() {
      threads[index]['likes'] = newLikes;
    });
  }

  void _editThread(int index) async {
    final editedThread = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => CreateThreadPage(
          initialTitle: threads[index]['title'],
          initialDescription: threads[index]['description'],
          initialImageUrl: threads[index]['imageUrl'],
        ),
      ),
    );

    if (editedThread != null) {
      setState(() {
        threads[index] = {
          ...threads[index],
          'title': editedThread['title'],
          'description': editedThread['description'],
          'imageUrl': editedThread['imageUrl'],
        };
      });
    }
  }

  void _deleteThread(int index) {
    setState(() {
      threads.removeAt(index);
    });
  }

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
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline, color: Color(0xFF9872EB)), // Updated color
            onPressed: () {
              _navigateToCreateThread(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: threads.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Space between cards
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF9872EB).withOpacity(0.5),
                  offset: Offset(-3, -3),
                  blurRadius: 10,
                ),
                BoxShadow(
                  color: Color(0xFFE871C5).withOpacity(0.5),
                  offset: Offset(3, 3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(threads[index]['profilePic'] ?? 'lib/assets/images/default.jpg'),
                    ),
                    SizedBox(width: 10),
                    Text(
                      threads[index]['username'] ?? 'Unknown User',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    if (threads[index]['isOwnPost'])
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert, color: Colors.white),
                        onSelected: (value) {
                          if (value == 'edit') {
                            _editThread(index);
                          } else if (value == 'delete') {
                            _deleteThread(index);
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ];
                        },
                      ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  threads[index]['title'] ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                if (threads[index]['imageUrl'] != null) // Show image if available
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      threads[index]['imageUrl'],
                      fit: BoxFit.cover,
                    ),
                  ),
                if (threads[index]['imageUrl'] != null)
                  SizedBox(height: 10),
                Text(
                  threads[index]['description'] ?? '',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        LikeButton(
                          initialLikes: threads[index]['likes'] ?? 0,
                          onLikeChanged: (newLikes) {
                            _updateLikes(index, newLikes);
                          },
                        ),
                        SizedBox(width: 5),
                        Text(
                          '${threads[index]['likes']} Likes',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => showCommentPage(context, index),
                      child: Row(
                        children: [
                          Icon(Icons.comment, color: Color(0xFFE871C5)),
                          SizedBox(width: 5),
                          Text(
                            '${threads[index]['comments']} Comments',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.share, color: Color(0xFF9872EB)), // Updated color
                      onPressed: () {
                        showShareOptions(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xFF1A1A1A),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.link, color: Color(0xFF9872EB)), // Updated color
                title: Text('Copy Link', style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Implement Copy Link functionality
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.report, color: Color(0xFFE871C5)), // Updated color
                title: Text('Report', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  showReportDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showReportDialog(BuildContext context) {
    TextEditingController reportController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF1A1A1A),
          title: Text('Report', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please describe the issue:', style: TextStyle(color: Colors.white70)),
              SizedBox(height: 10),
              TextField(
                controller: reportController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF2A2A2A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Write your report here...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Send', style: TextStyle(color: Color(0xFFE871C5))),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Report sent. Wait for feedback.'),
                    backgroundColor: Color(0xFF1A1A1A),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class LikeButton extends StatefulWidget {
  final int initialLikes;
  final ValueChanged<int> onLikeChanged;

  LikeButton({required this.initialLikes, required this.onLikeChanged});

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;
  late int likes;

  @override
  void initState() {
    super.initState();
    likes = widget.initialLikes;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.thumb_up,
        color: isLiked ? Color(0xFFE871C5) : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          isLiked = !isLiked;
          likes = isLiked ? likes + 1 : likes - 1;
          widget.onLikeChanged(likes);
        });
      },
    );
  }
}
