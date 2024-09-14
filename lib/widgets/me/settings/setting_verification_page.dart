// File: lib/widgets/me/settings/setting_verification_page.dart

import 'dart:async';
import 'package:flutter/material.dart';

class SettingVerificationPage extends StatefulWidget {
  final String phoneNumber;

  SettingVerificationPage({required this.phoneNumber});

  @override
  _SettingVerificationPageState createState() => _SettingVerificationPageState();
}

class _SettingVerificationPageState extends State<SettingVerificationPage> {
  String _verificationCode = '';
  int _secondsRemaining = 60;
  bool _isButtonEnabled = false;
  bool _isResendButtonVisible = false;
  bool _isVerificationComplete = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _isResendButtonVisible = true;
        });
        _timer.cancel();
      }
    });
  }

  void _onCodeChanged(String value) {
    setState(() {
      _verificationCode = value;
      _isButtonEnabled = _verificationCode.length == 6; // Assuming the code is 6 digits long
    });
  }

  void _resendCode() {
    setState(() {
      _secondsRemaining = 60;
      _isResendButtonVisible = false;
    });
    _startTimer();
  }

  void _onSubmit() {
    setState(() {
      _isVerificationComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _isVerificationComplete
              ? _buildPasswordFields()
              : _buildVerificationFields(),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  List<Widget> _buildVerificationFields() {
    return [
      Text(
        'Verification code has been sent to your phone',
        style: TextStyle(color: Colors.white),
      ),
      SizedBox(height: 10),
      Text(
        'Phone: ${widget.phoneNumber}',
        style: TextStyle(color: Colors.white70),
      ),
      SizedBox(height: 20),
      TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: 'Code',
          labelStyle: TextStyle(color: Colors.white70),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        keyboardType: TextInputType.number,
        onChanged: _onCodeChanged,
      ),
      SizedBox(height: 20),
      Text(
        _secondsRemaining > 0
            ? 'Your SMS should arrive in $_secondsRemaining second(s).'
            : 'Didn\'t receive the code?',
        style: TextStyle(color: Colors.white70),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 10),
      if (_isResendButtonVisible)
        TextButton(
          onPressed: _resendCode,
          child: Text(
            'Resend Code',
            style: TextStyle(color: Color(0xFFE871C5)),
          ),
        ),
      SizedBox(height: 20),
      Container(
        decoration: _isButtonEnabled
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: ElevatedButton(
          onPressed: _isButtonEnabled ? _onSubmit : null,
          child: Text('Submit'),
          style: ElevatedButton.styleFrom(
            backgroundColor: _isButtonEnabled ? Colors.transparent : Colors.grey,
            shadowColor: Colors.transparent,
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildPasswordFields() {
    return [
      TextField(
        obscureText: true,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: 'New Password',
          labelStyle: TextStyle(color: Colors.white70),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onChanged: (value) {
          // Handle new password input
        },
      ),
      SizedBox(height: 20),
      TextField(
        obscureText: true,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: 'Confirm New Password',
          labelStyle: TextStyle(color: Colors.white70),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onChanged: (value) {
          // Handle confirm password input
        },
      ),
      SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          // পাসওয়ার্ড পরিবর্তন লজিক
        },
        child: Text('Change Password'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFE871C5),
        ),
      ),
    ];
  }
}
