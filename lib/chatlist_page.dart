import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart'; // google_ml_kit প্যাকেজ ব্যবহার করা হলো
import 'package:image_picker/image_picker.dart'; // For capturing image using camera
import 'chat_page.dart'; // ChatPage ইম্পোর্ট করা হলো
import 'widgets/custom_navbar.dart'; // CustomNavBar import করা হলো
import 'widgets/chat/money_page.dart'; // MoneyPage পেজ ইম্পোর্ট করা হলো
import 'widgets/chatlist/add_contact_page.dart'; // AddContactPage ইম্পোর্ট করা হলো
import 'widgets/chatlist/invite_friends_page.dart'; // InviteFriendsPage ইম্পোর্ট করা হলো

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage>
    with SingleTickerProviderStateMixin {
  bool isDropdownOpen = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  OverlayEntry? _overlayEntry;
  final String userId = 'Tomioka_Giyuu'; // MePage থেকে পাওয়া userId

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _toggleDropdown() {
    setState(() {
      if (isDropdownOpen) {
        _controller.reverse();
        _overlayEntry?.remove(); // Overlay বন্ধ করা
      } else {
        _controller.forward();
        _overlayEntry = _createOverlayEntry(); // Overlay ওপেন করা
        Overlay.of(context)?.insert(_overlayEntry!);
      }
      isDropdownOpen = !isDropdownOpen;
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        top: kToolbarHeight + 10, // অ্যাপবারের নিচে থাকবে
        right: 10,
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF9872EB).withOpacity(0.3),
                    offset: Offset(-4, -4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Color(0xFFE871C5).withOpacity(0.3),
                    offset: Offset(4, 4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align left to right
                children: [
                  _buildDropdownItem(
                      'Add Contacts', 'lib/assets/icons/add_contact_icon.png', () {
                        _closeDropdown();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddContactPage(
                                  userId: userId)), // userId পাস করা হয়েছে
                        );
                      }),
                  _buildDropdownItem(
                      'Scan', 'lib/assets/icons/scan_icon.png', () {
                    _closeDropdown();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScanPage()),
                    ); // স্ক্যান পেজে পাঠানো
                  }),
                  _buildDropdownItem(
                      'Money', 'lib/assets/icons/money_icon.png', () {
                        _closeDropdown(); // ড্রপডাউন মেনু বন্ধ করা
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MoneyPage()),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _closeDropdown() {
    setState(() {
      if (isDropdownOpen) {
        _controller.reverse();
        _overlayEntry?.remove();
        isDropdownOpen = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _closeDropdown(); // স্ক্রিনের বাইরে ক্লিক করলে ড্রপডাউন মেনু বন্ধ হবে
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: Center(
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds),
              child: Text(
                'Gen-Z',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds),
                child: Icon(Icons.add, color: Colors.white),
              ),
              onPressed: _toggleDropdown,
            ),
          ],
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF9872EB).withOpacity(0.3),
                        offset: Offset(-4, -4),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Color(0xFFE871C5).withOpacity(0.3),
                        offset: Offset(4, 4),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 2, // Number of chats
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                                'lib/assets/images/profile$index.jpg'),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: index == 0 ? Colors.green : Colors.grey,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        index == 0 ? 'Gen-Z Team' : 'Tomioka Giyuu',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        index == 0
                            ? 'Welcome to Gen-Z.'
                            : 'I\'m Good...Thank You',
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: Text(
                        'Today 10.0${index + 2} AM',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        // চ্যাট আইটেম ক্লিক করলে chat_page এ চলে যাবে
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              userName: index == 0
                                  ? 'EyesMeet Team'
                                  : 'Tomioka Giyuu', // userName প্যারামিটার পাস করা হয়েছে
                              profileImage: 'lib/assets/images/profile$index.jpg', // String হিসেবে path পাস করা হয়েছে
                              lastActive: DateTime.now(), // lastActive প্যারামিটার DateTime হিসেবে পাস করা হয়েছে
                            ),
                          ),
                        );
                      },
                      onLongPress: () {
                        _showMessageOptions(context, index);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InviteFriendsPage()),
                    );
                  },
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds),
                    child: Text(
                      'Invite Friends To Register >',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomNavBar(
          currentIndex: 0,
          onTap: (index) {},
        ),
      ),
    );
  }

  Widget _buildDropdownItem(String text, String iconPath, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align left to right in each row
          children: [
            Image.asset(iconPath, color: null, height: 24), // Custom icon without color change
            SizedBox(width: 10),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds),
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessageOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.reply, color: Colors.white),
                title: Text('Reply', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.copy, color: Colors.white),
                title: Text('Copy', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.forward, color: Colors.white),
                title: Text('Forward', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Delete', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final BarcodeScanner barcodeScanner = GoogleMlKit.vision.barcodeScanner(); // google_ml_kit এর নতুন Scanner ব্যবহার করা হয়েছে
  final ImagePicker _picker = ImagePicker(); // For selecting images from camera

  @override
  void initState() {
    super.initState();
    _scanBarcode(); // Page load হলে সরাসরি ক্যামেরা খুলবে
  }

  @override
  void dispose() {
    barcodeScanner.close(); // স্ক্যানার বন্ধ করা হবে যখন পেজ ডিসপোজ হবে
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // স্ক্যান করার সময় ব্যাকগ্রাউন্ড সাদা না দেখানোর জন্য কালো করা হলো
    );
  }

  Future<void> _scanBarcode() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera); // Camera থেকে ছবি নেওয়া হচ্ছে
      if (image == null) {
        Navigator.pop(context); // If no image was captured, return back
        return;
      }

      final inputImage = InputImage.fromFilePath(image.path); // Image path ব্যবহার করে inputImage তৈরি করা হলো
      final List<Barcode> barcodes = await barcodeScanner.processImage(inputImage); // স্ক্যান করা বারকোডগুলো প্রসেস করা হবে

      for (Barcode barcode in barcodes) {
        final String? rawValue = barcode.rawValue; // displayValue এর পরিবর্তে rawValue ব্যবহার করা হলো
        if (rawValue != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Scanned Code: $rawValue')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No valid code found')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      Navigator.pop(context); // After processing, return back to the previous page
    }
  }
}
