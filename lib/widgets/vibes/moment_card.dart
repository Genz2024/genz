import 'package:flutter/material.dart';
import 'comment_page.dart';

class MomentCard extends StatefulWidget {
  final String imageUrl;
  final String caption;
  final int likes;
  final int comments;
  final String username;
  final String profilePic;
  final DateTime uploadTime;
  final bool isOwner;

  MomentCard({
    required this.imageUrl,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.username,
    required this.profilePic,
    required this.uploadTime,
    required this.isOwner,
  });

  @override
  _MomentCardState createState() => _MomentCardState();
}

class _MomentCardState extends State<MomentCard> {
  int likes = 0;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    likes = widget.likes;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        likes++;
      } else {
        likes--;
      }
    });
  }

  String formatTime(DateTime time) {
    Duration difference = DateTime.now().difference(time);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}d ago';
    } else {
      return '${difference.inDays ~/ 30}m ago';
    }
  }

  void showCommentPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentPage(
          imageUrl: widget.imageUrl,
          caption: widget.caption,
          likes: likes,
          comments: [
            {
              'username': 'User1',
              'profilePic': 'lib/assets/images/profile0.jpg',
              'comment': 'Beautiful!',
            },
            {
              'username': 'User2',
              'profilePic': 'lib/assets/images/profile1.jpg',
              'comment': 'Amazing view!',
            },
            // আরও মন্তব্য এখানে যোগ করুন
          ],
        ),
      ),
    );
  }

  void showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.link),
                title: Text('Copy Link'),
                onTap: () {
                  // লিঙ্ক কপি করার লজিক এখানে
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Link copied to clipboard')),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.report),
                title: Text('Report'),
                onTap: () {
                  // রিপোর্ট করার লজিক এখানে
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Reported')),
                  );
                },
              ),
              if (widget.isOwner) ...[
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit Caption'),
                  onTap: () {
                    // সম্পাদনা করার লজিক এখানে
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Edit option selected')),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete Moment'),
                  onTap: () {
                    // মুছে ফেলার লজিক এখানে
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Moment deleted')),
                    );
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20), // গ্যাপের জন্য উল্লম্ব মার্জিন বৃদ্ধি করা হয়েছে
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF9872EB).withOpacity(0.2), // নিউওমরফিক ছায়া রং
            offset: Offset(-5, -5),
            blurRadius: 10,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Color(0xFFE871C5).withOpacity(0.2), // নিউওমরফিক ছায়া রং
            offset: Offset(5, 5),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.profilePic),
                    radius: 20,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.username,
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        formatTime(widget.uploadTime),
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              if (widget.isOwner) 
                IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.white),
                  onPressed: () {
                    showShareOptions(context);
                  },
                ),
            ],
          ),
          SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(
            widget.caption,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: toggleLike,
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        if (isLiked) {
                          return LinearGradient(
                            colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        } else {
                          return LinearGradient(
                            colors: [Colors.grey, Colors.grey],
                          ).createShader(bounds);
                        }
                      },
                      child: Icon(
                        Icons.thumb_up,
                        color: Colors.white, // রঙ Shader দ্বারা কভার করা হবে
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '$likes Likes',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  showCommentPage(context);
                },
                child: Row(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Icon(Icons.comment, color: Colors.white),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '${widget.comments} Comments',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: IconButton(
                  icon: Icon(Icons.share, color: Colors.white),
                  onPressed: () {
                    showShareOptions(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
