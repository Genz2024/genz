import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Clipboard support
import 'package:image_picker/image_picker.dart'; // For image picking
import 'dart:io'; // File class import

class CommentPage extends StatefulWidget {
  final String imageUrl;
  final String caption;
  final int likes;
  final List<Map<String, dynamic>> comments;

  CommentPage({
    required this.imageUrl,
    required this.caption,
    required this.likes,
    required this.comments,
  });

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController commentController = TextEditingController();
  List<Map<String, dynamic>> commentsList = [];
  String? replyingTo;

  @override
  void initState() {
    super.initState();
    commentsList = widget.comments;
  }

  void addComment(String commentText, {String? imageUrl}) {
    setState(() {
      commentsList.add({
        'username': 'CurrentUser',
        'profilePic': 'lib/assets/images/default.jpg', // Default profile pic
        'comment': commentText,
        'imageUrl': imageUrl, // Add image URL if provided
      });
      commentController.clear();
      replyingTo = null;
    });
  }

  void copyComment(String commentText) {
    Clipboard.setData(ClipboardData(text: commentText));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Comment copied to clipboard')),
    );
  }

  void hideComment(int index) {
    setState(() {
      commentsList[index]['comment'] = 'This comment has been hidden';
    });
  }

  void deleteComment(int index) {
    setState(() {
      commentsList.removeAt(index);
    });
  }

  void showCommentOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.copy),
                title: Text('Copy'),
                onTap: () {
                  copyComment(commentsList[index]['comment']);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.visibility_off),
                title: Text('Hide'),
                onTap: () {
                  hideComment(index);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  deleteComment(index);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to pick images
  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      addComment('', imageUrl: pickedFile.path); // Add the image as a comment
    }
  }

  // Function to open camera
  Future<void> openCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      addComment('', imageUrl: pickedFile.path); // Add the captured image as a comment
    }
  }

  // Function to pick GIFs (Placeholder, implement your GIF picker)
  void pickGif() {
    print("GIF picker opened");
    // Add logic to pick and add GIFs to comments
  }

  // Function to pick Stickers (Placeholder, implement your Sticker picker)
  void pickSticker() {
    print("Sticker picker opened");
    // Add logic to pick and add Stickers to comments
  }

  // Function to show full-screen image
  void showFullScreenImage(BuildContext context, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImagePage(imagePath: imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Comments', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Image and Caption
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(widget.imageUrl, fit: BoxFit.cover),
                        ),
                        SizedBox(height: 10),
                        Text(widget.caption, style: TextStyle(color: Colors.white)),
                        SizedBox(height: 5),
                        Text('${widget.likes} Likes', style: TextStyle(color: Colors.pinkAccent)),
                      ],
                    ),
                  ),
                  Divider(color: Colors.white),
                  // Comments Section
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: commentsList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () {
                          showCommentOptions(context, index);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(commentsList[index]['profilePic']!),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      commentsList[index]['username'], // Displaying username
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (commentsList[index]['imageUrl'] != null)
                                      GestureDetector(
                                        onTap: () {
                                          showFullScreenImage(context, commentsList[index]['imageUrl']);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: Image.file(
                                              File(commentsList[index]['imageUrl']),
                                              width: 100, // Smaller width for the image bubble
                                              height: 140, // Updated height for the image bubble
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    // Remove the empty Container or BoxDecoration if exists
                                    Container(
                                      margin: EdgeInsets.only(top: 2), // Add some spacing between username and comment
                                      padding: EdgeInsets.all(10),
                                      constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width * 0.75, // Fixed width of bubble
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1A1A1A),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        commentsList[index]['comment'], // Displaying comment
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          replyingTo = commentsList[index]['username'];
                                        });
                                      },
                                      child: Text('Reply', style: TextStyle(color: Colors.pinkAccent)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Reply Context (if any)
          if (replyingTo != null)
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    'Replying to $replyingTo',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white70),
                    onPressed: () {
                      setState(() {
                        replyingTo = null;
                      });
                    },
                  ),
                ],
              ),
            ),
          // Input for new comment with media options
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.pinkAccent),
                  onPressed: openCamera,
                ),
                IconButton(
                  icon: Icon(Icons.image, color: Colors.pinkAccent),
                  onPressed: pickImage,
                ),
                IconButton(
                  icon: Icon(Icons.gif, color: Colors.pinkAccent),
                  onPressed: pickGif,
                ),
                IconButton(
                  icon: Icon(Icons.emoji_emotions, color: Colors.pinkAccent),
                  onPressed: pickSticker,
                ),
                Expanded(
                  child: TextField(
                    controller: commentController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white, // Make the input bar white
                      hintText: 'Write a comment...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.pinkAccent),
                  onPressed: () {
                    if (commentController.text.isNotEmpty) {
                      addComment(commentController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// FullScreenImagePage widget to show the image in full screen
class FullScreenImagePage extends StatelessWidget {
  final String imagePath;

  FullScreenImagePage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Image.file(
          File(imagePath),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
