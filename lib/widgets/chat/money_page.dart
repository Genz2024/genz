import 'package:flutter/material.dart';
import 'package:genz/chatlist_page.dart';

class MoneyPage extends StatefulWidget {
  @override
  _MoneyPageState createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChatListPage()));
          },
        ),
        title: Center(
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds),
            child: Text(
              'Money',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // উপরের অংশ (পেমেন্ট কোড)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  padding: EdgeInsets.all(20),  // সাদা বাক্স বড় করা হয়েছে
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'lib/assets/icons/scan_icon.png',
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(width: 10),
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds),
                            child: Text(
                              'Payment Code',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: Icon(Icons.info, color: Colors.grey, size: 24),
                      ),
                      SizedBox(height: 20), // গ্যাপ বড় করা হয়েছে
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Quick pay not enabled.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Enable it to make paying merchants',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'fast and easy - Flash the code and go.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30), // You have read এর সাথে গ্যাপ বড় করা হয়েছে
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          Flexible(
                            child: RichText(
                              textAlign: TextAlign.left,  // বাম দিকে সরানো হয়েছে
                              text: TextSpan(
                                text: 'You have read and agree to the ',
                                style: TextStyle(
                                  fontSize: 12,  // ফন্ট ছোট করা হয়েছে
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Payment User Service Agreement',
                                    style: TextStyle(
                                      fontSize: 12,
                                      foreground: Paint()
                                        ..shader = LinearGradient(
                                          colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                                        ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20), // বাটনের নিচে গ্যাপ বাড়ানো হয়েছে
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isChecked
                                ? [Color(0xFF9872EB), Color(0xFFE871C5)]
                                : [Colors.grey, Colors.grey],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          onPressed: isChecked ? () {} : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            shadowColor: Colors.transparent,
                          ),
                          child: Text('Enable'),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.privacy_tip,
                            color: Colors.grey,
                            size: 16,
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              'EyesMeet Pay ensures the security of your funds.',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // নিচের অংশ (পেমেন্ট অপশনস)
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(12),  // নিচের ফাংশনগুলোর সাইজ ছোট করা হয়েছে
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildPaymentOption(
                        iconPath: 'lib/assets/icons/receive_money.png',
                        label: 'Receive Money',
                        onTap: () {
                          // Receive Money অপশন হ্যান্ডেল করা হবে
                        },
                      ),
                      SizedBox(height: 10),
                      _buildPaymentOption(
                        iconPath: 'lib/assets/icons/reward_code.png',
                        label: 'Reward Code',
                        onTap: () {
                          // Reward Code অপশন হ্যান্ডেল করা হবে
                        },
                      ),
                      SizedBox(height: 10),
                      _buildPaymentOption(
                        iconPath: 'lib/assets/icons/split_bill.png',
                        label: 'Split Bill',
                        onTap: () {
                          // Split Bill অপশন হ্যান্ডেল করা হবে
                        },
                      ),
                      SizedBox(height: 10),
                      _buildPaymentOption(
                        iconPath: 'lib/assets/icons/transfer.png',
                        label: 'Transfer to Bank Card/Mobile No.',
                        onTap: () {
                          // Transfer to Bank Card/Mobile No. অপশন হ্যান্ডেল করা হবে
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required String iconPath,
    required String label,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),  // বাটনের প্যাডিং কমানো হয়েছে
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, height: 24),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}
