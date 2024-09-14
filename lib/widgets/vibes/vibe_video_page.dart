import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class VibeVideoPage extends StatelessWidget {
  final List<Map<String, dynamic>> videos = [
    {
      'username': 'User1',
      'profilePic': 'lib/assets/images/profile0.jpg',
      'videoUrl': 'lib/assets/videos/video1.mp4',
      'likes': 150,
      'comments': 25,
      'caption': 'This is a cool vibe! #vibe #cool'
    },
    {
      'username': 'User2',
      'profilePic': 'lib/assets/images/profile1.jpg',
      'videoUrl': 'lib/assets/videos/video2.mp4',
      'likes': 230,
      'comments': 40,
      'caption': 'Loving this moment! #moment #vibes'
    },
    {
      'username': 'User3',
      'profilePic': 'lib/assets/images/profile2.jpg',
      'videoUrl': 'lib/assets/videos/video3.mp4',
      'likes': 100,
      'comments': 15,
      'caption': 'Just chilling here... #chill #vibes'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Vibes',
          style: TextStyle(
            fontSize: 18,
            foreground: Paint()
              ..shader = LinearGradient(
                colors: <Color>[Color(0xFF9872EB), Color(0xFFE871C5)],
              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Color(0xFFE871C5)), // Top right icon is a plus icon
            onPressed: () {
              _showOptions(context);
            },
          ),
        ],
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return VibeVideoCard(videoData: videos[index]);
        },
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Color(0xFF1A1A1A),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.add, color: Color(0xFFE871C5)),
                title: Text('Create Vibe', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _createVibe(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.upload, color: Color(0xFFE871C5)),
                title: Text('Upload Vibe', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _uploadVibe(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _createVibe(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? video = await _picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: Duration(seconds: 60),
    );

    if (video != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NextAndCaptionPage(videoPath: video.path),
        ),
      );
    }
  }

  Future<void> _uploadVibe(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? video = await _picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: Duration(seconds: 60),
    );

    if (video != null) {
      if (video.path.endsWith('.mp4')) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NextAndCaptionPage(videoPath: video.path),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Only .mp4 files are allowed!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class VibeVideoCard extends StatefulWidget {
  final Map<String, dynamic> videoData;

  VibeVideoCard({required this.videoData});

  @override
  _VibeVideoCardState createState() => _VibeVideoCardState();
}

class _VibeVideoCardState extends State<VibeVideoCard> {
  late VideoPlayerController _controller;
  bool isLiked = false;
  int likesCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoData['videoUrl'])
      ..initialize().then((_) {
        setState(() {}); // Rebuild widget once video is initialized
      })
      ..setLooping(true)
      ..play();

    isLiked = false;
    likesCount = widget.videoData['likes'] ?? 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likesCount += isLiked ? 1 : -1;
    });
  }

  void _showComments(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CommentSection(videoData: widget.videoData);
      },
    );
  }

  void _showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Color(0xFF1A1A1A),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.copy, color: Colors.white),
                title: Text('Copy Link', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Link copied to clipboard!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.report, color: Colors.red),
                title: Text('Report', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _showReportForm(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showReportForm(BuildContext context) {
    final TextEditingController _reportController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF1A1A1A),
          title: Text('Report', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: _reportController,
            maxLines: 5,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Describe the issue...',
              hintStyle: TextStyle(color: Colors.white54),
              filled: true,
              fillColor: Color(0xFF333333),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Report sent. Please wait for feedback.'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE871C5),
              ),
              child: Text('Send', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _controller.value.isInitialized
            ? Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              )
            : Center(child: CircularProgressIndicator()),
        Positioned(
          top: 50,
          left: 20,
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(widget.videoData['profilePic']),
              ),
              SizedBox(width: 10),
              Text(
                widget.videoData['username'],
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.videoData['caption'] ?? '',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: _toggleLike,
                    child: Column(
                      children: [
                        Icon(
                          Icons.thumb_up,
                          color: isLiked ? Color(0xFFE871C5) : Colors.grey,
                        ),
                        SizedBox(height: 5),
                        Text(
                          '$likesCount Likes',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () => _showComments(context),
                    child: Column(
                      children: [
                        Icon(Icons.comment, color: Color(0xFF9872EB)),
                        SizedBox(height: 5),
                        Text(
                          '${widget.videoData['comments']} Comments',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () => _showShareOptions(context),
                    child: Column(
                      children: [
                        Icon(Icons.share, color: Color(0xFFE871C5)),
                        SizedBox(height: 5),
                        Text(
                          'Share',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NextAndCaptionPage extends StatefulWidget {
  final String videoPath;

  NextAndCaptionPage({required this.videoPath});

  @override
  _NextAndCaptionPageState createState() => _NextAndCaptionPageState();
}

class _NextAndCaptionPageState extends State<NextAndCaptionPage> {
  final TextEditingController _captionController = TextEditingController();
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Add Caption', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _captionController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Write a caption...',
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Color(0xFF1A1A1A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: _isUploading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isUploading = true;
                        });

                        // Simulate an upload process
                        await Future.delayed(Duration(seconds: 2));

                        setState(() {
                          _isUploading = false;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Vibe uploaded successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );

                        Navigator.pop(context);
                      },
                      child: Text('Upload', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE871C5),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentSection extends StatefulWidget {
  final Map<String, dynamic> videoData;

  CommentSection({required this.videoData});

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _commentController = TextEditingController();
  List<Map<String, dynamic>> comments = [];

  void _addComment() {
    setState(() {
      if (_commentController.text.isNotEmpty) {
        comments.add({
          'username': 'User${comments.length + 1}',
          'comment': _commentController.text,
          'profilePic': 'lib/assets/images/profile_placeholder.png',
          'isHidden': false, // Hide/Unhide flag
        });
        _commentController.clear();
      }
    });
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Color(0xFF1A1A1A),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.visibility_off, color: Colors.white),
                title: Text('Hide Comment', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    comments[index]['isHidden'] = true;
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Delete Comment', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    comments.removeAt(index);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF1A1A1A),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Comments',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return GestureDetector(
                    onLongPress: () => _showOptions(context, index),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(comment['profilePic']),
                            ),
                            SizedBox(width: 10),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: comment['isHidden']
                                    ? Colors.grey
                                    : Color(0xFF333333),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                comment['isHidden']
                                    ? 'Comment Hidden'
                                    : comment['comment'],
                                style: TextStyle(color: Colors.white70),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            // Add reply functionality here
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 60.0, top: 5, bottom: 10),
                            child: Text(
                              'Reply',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.image, color: Colors.white),
                  onPressed: () {
                    // Image picker functionality can be added here
                  },
                ),
                IconButton(
                  icon: Icon(Icons.gif, color: Colors.white),
                  onPressed: () {
                    // GIF picker functionality can be added here
                  },
                ),
                IconButton(
                  icon: Icon(Icons.emoji_emotions, color: Colors.white),
                  onPressed: () {
                    // Sticker/Emoji picker functionality can be added here
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      hintStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Color(0xFF1A1A1A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.white),
                  onPressed: _addComment,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
