import 'package:flutter/material.dart';
import 'countries.dart'; // Country তালিকা ইম্পোর্ট
import 'setting_verification_page.dart'; // Verification পেজ ইম্পোর্ট

class ChangeMobilePage extends StatefulWidget {
  @override
  _ChangeMobilePageState createState() => _ChangeMobilePageState();
}

class _ChangeMobilePageState extends State<ChangeMobilePage> {
  String _selectedRegion = 'Bangladesh';
  String _countryCode = '+880';
  String _phoneNumber = '';

  void _selectCountry() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.black,
          child: ListView.builder(
            itemCount: countries.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(countries[index]['name']!, style: TextStyle(color: Colors.white)),
                trailing: Text(countries[index]['code']!, style: TextStyle(color: Colors.white70)),
                onTap: () {
                  setState(() {
                    _selectedRegion = countries[index]['name']!;
                    _countryCode = countries[index]['code']!;
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Mobile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'After changing, you can log in to the account with the new mobile number.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Region', style: TextStyle(color: Colors.white)),
              trailing: Text(_selectedRegion, style: TextStyle(color: Colors.white70)),
              onTap: _selectCountry, // Region বারে ক্লিক করলে Country List শো করবে
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Phone',
                labelStyle: TextStyle(color: Colors.white70),
                prefixText: '$_countryCode ',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  _phoneNumber = value;
                });
              },
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingVerificationPage(phoneNumber: _countryCode + _phoneNumber)),
                  );
                },
                child: Text('Next'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // ব্যাকগ্রাউন্ড কালার সরানো হয়েছে যাতে গ্রেডিয়েন্ট দেখা যায়
                  shadowColor: Colors.transparent, // শ্যাডো সরানো হয়েছে
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
