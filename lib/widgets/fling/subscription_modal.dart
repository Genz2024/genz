import 'package:flutter/material.dart';

class SubscriptionModal extends StatefulWidget {
  @override
  _SubscriptionModalState createState() => _SubscriptionModalState();
}

class _SubscriptionModalState extends State<SubscriptionModal> {
  String selectedPackage = ''; // কোন প্যাকেজ প্রথমে সিলেক্ট করা হয়নি

  void _selectPackage(String package) {
    setState(() {
      // যদি আগের সিলেক্ট করা প্যাকেজে আবার ক্লিক করা হয় তবে আনসিলেক্ট করা হবে
      if (selectedPackage == package) {
        selectedPackage = '';
      } else {
        selectedPackage = package;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFFE871C5), Color(0xFF9872EB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              'Gen-Z Premium Subscription',
              style: TextStyle(
                color: Colors.white,  // গ্রেডিয়েন্ট শ্যাডার যোগ করা হলো
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                shadows: [
                  Shadow(
                    blurRadius: 5,
                    color: Colors.pink.withOpacity(0.8),
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildSubscriptionSlider(), // স্লাইড কার্ড বিল্ড করা হয়েছে
          SizedBox(height: 20),
          _buildBenefitsSection(), // বেনিফিট সেকশন
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: selectedPackage.isNotEmpty
                ? () {
                    Navigator.pop(context);
                    // সাবস্ক্রিপশন কনটিনিউ বাটন প্রেসের পরে হ্যান্ডেলিং
                  }
                : null, // বাটন ডিসেবল থাকবে যদি কোন প্যাকেজ সিলেক্ট না হয়
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFE871C5), // বাটনের ব্যাকগ্রাউন্ড রঙ
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'Continue',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionSlider() {
    return Column(
      children: [
        SizedBox(
          height: 180, // কার্ডের উচ্চতা
          child: PageView(
            controller: PageController(viewportFraction: 0.9),
            children: [
              _buildSubscriptionOption(
                'Weekly Subscription',
                '৳100 BDT per week',
                'Save 0%',
                Colors.pinkAccent,
                'weekly',
              ),
              _buildSubscriptionOption(
                'Monthly Subscription',
                '৳200 BDT per month',
                'Save 50%',
                Colors.purpleAccent,
                'monthly',
              ),
              _buildSubscriptionOption(
                'Yearly Subscription',
                '৳1000 BDT per year',
                'Save 80%',
                Colors.orangeAccent,
                'yearly',
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        _buildPageIndicator(),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDot(isActive: selectedPackage == 'weekly'),
        _buildDot(isActive: selectedPackage == 'monthly'),
        _buildDot(isActive: selectedPackage == 'yearly'),
      ],
    );
  }

  Widget _buildDot({required bool isActive}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.pinkAccent : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildSubscriptionOption(
    String title,
    String price,
    String discount,
    Color color,
    String packageName,
  ) {
    bool isSelected = selectedPackage == packageName; // প্যাকেজ সিলেক্ট করা হয়েছে কি না চেক
    return GestureDetector(
      onTap: () {
        _selectPackage(packageName); // প্যাকেজ সিলেক্ট বা আনসিলেক্ট করা হচ্ছে
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.3) : Colors.black,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: isSelected ? color : Colors.grey),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                _buildSelectionCircle(isSelected, color), // সিলেক্ট চিহ্ন দেখানোর জন্য বৃত্ত
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              price,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              discount,
              style: TextStyle(color: Colors.greenAccent, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionCircle(bool isSelected, Color color) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: isSelected ? color : Colors.grey, width: 2),
        color: isSelected ? color : Colors.transparent,
      ),
      child: isSelected
          ? Icon(Icons.check, size: 16, color: Colors.white)
          : null,
    );
  }

  Widget _buildBenefitsSection() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Subscription Benefits:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(height: 10),
          _buildBenefitItem('💳 Swipe unlimited', Colors.pinkAccent),
          _buildBenefitItem('🚫 No ads for nearby people', Colors.greenAccent),
          _buildBenefitItem('🗺 See nearby people anytime', Colors.orangeAccent),
          _buildBenefitItem('💌 Send unlimited greetings', Colors.purpleAccent),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String benefit, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Benefits center করা হয়েছে
        children: [
          Icon(Icons.circle, size: 10, color: color), // ইমোজি বা ডট রঙ
          SizedBox(width: 8),
          Text(
            benefit,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

void showSubscriptionModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => SubscriptionModal(),
  );
}
