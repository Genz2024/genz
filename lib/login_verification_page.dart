import 'package:flutter/material.dart';
import 'dart:async';

class LoginVerificationPage extends StatefulWidget {
  final String? countryCode;
  final String? countryName;
  final String? phoneNumber;

  LoginVerificationPage({
    required this.countryCode,
    required this.countryName,
    required this.phoneNumber,
  });

  @override
  _LoginVerificationPageState createState() => _LoginVerificationPageState();
}

class _LoginVerificationPageState extends State<LoginVerificationPage>
    with TickerProviderStateMixin {
  final _verificationCodeController = TextEditingController();
  bool _isButtonActive = false;
  int _timerCountdown = 60;

  @override
  void initState() {
    super.initState();
    _startCountdown();
    _verificationCodeController.addListener(_validateInput);
  }

  void _startCountdown() {
    Future.doWhile(() async {
      if (_timerCountdown > 0) {
        await Future.delayed(Duration(seconds: 1));
        setState(() {
          _timerCountdown--;
        });
        return true;
      } else {
        return false;
      }
    });
  }

  void _validateInput() {
    setState(() {
      _isButtonActive = _verificationCodeController.text.isNotEmpty;
    });
  }

  void _resendCode() {
    setState(() {
      _timerCountdown = 60;
      _startCountdown();
    });
  }

  @override
  void dispose() {
    _verificationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/verification.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: _buildVerificationCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationCard() {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 10,
      shadowColor: Color(0xFFE4FEFE).withOpacity(0.6),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.white),
                children: [
                  TextSpan(text: 'Enter the verification code sent to '),
                  TextSpan(
                    text: '${widget.countryCode}${widget.phoneNumber}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' (${widget.countryName})'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF1B1B1B),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFE4FEFE).withOpacity(0.6),
                    offset: Offset(-5, -5),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(5, 5),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: TextField(
                controller: _verificationCodeController,
                decoration: InputDecoration(
                  labelText: 'Verification Code',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            _timerCountdown > 0
                ? Text(
                    'Please wait $_timerCountdown seconds to receive the code.',
                    style: TextStyle(color: Colors.white54),
                  )
                : GestureDetector(
                    onTap: _resendCode,
                    child: Text(
                      'Resend code',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isButtonActive
                  ? () {
                      // Here you can navigate to the next page after verification
                      Navigator.pushNamed(context, '/chatlist');
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isButtonActive ? Color(0xFFE4FEFE) : Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
