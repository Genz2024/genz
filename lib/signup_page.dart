import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:io' show Platform;  // To detect platform

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscurePassword = true;
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isButtonActive = false;
  bool _termsAccepted = false;
  String _selectedRegion = 'Select Region';
  String? _selectedCountryCode;
  String? _selectedCountryName;
  List<dynamic> _countries = [];

  // Error messages
  String? _fullNameError;
  String? _phoneNumberError;
  String? _passwordError;

  // Add touched flag
  bool _fullNameTouched = false;
  bool _phoneNumberTouched = false;
  bool _passwordTouched = false;

  @override
  void initState() {
    super.initState();
    _fullNameController.addListener(_validateFullName);
    _phoneNumberController.addListener(_validatePhoneNumber);
    _passwordController.addListener(_validatePassword);
    _loadCountries();
  }

  void _validateFullName() {
    setState(() {
      _fullNameTouched = true;
      if (RegExp(r'^[a-zA-Z\s]+$').hasMatch(_fullNameController.text)) {
        _fullNameError = null;
      } else {
        _fullNameError = 'Full Name can only contain letters';
      }
      _checkInputFields();
    });
  }

  void _validatePhoneNumber() {
    setState(() {
      _phoneNumberTouched = true;
      if (RegExp(r'^[0-9]+$').hasMatch(_phoneNumberController.text)) {
        _phoneNumberError = null;
      } else {
        _phoneNumberError = 'Phone number can only contain digits';
      }
      _checkInputFields();
    });
  }

  void _validatePassword() {
    setState(() {
      _passwordTouched = true;
      if (_passwordController.text.length >= 8 &&
          _passwordController.text.length <= 16 &&
          RegExp(r'[A-Z]').hasMatch(_passwordController.text) &&
          RegExp(r'[0-9]').hasMatch(_passwordController.text) &&
          RegExp(r'[!@#\$&*~]').hasMatch(_passwordController.text)) {
        _passwordError = null;
      } else {
        _passwordError =
            'Password must contain 1 uppercase, 1 number, 1 special character';
      }
      _checkInputFields();
    });
  }

  void _checkInputFields() {
    setState(() {
      _isButtonActive = _fullNameController.text.isNotEmpty &&
          _phoneNumberController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _fullNameError == null &&
          _phoneNumberError == null &&
          _passwordError == null &&
          _selectedRegion != 'Select Region' &&  // Region must be selected
          _selectedCountryCode != null &&        // Country must be selected
          _termsAccepted;
    });
  }

  Future<void> _loadCountries() async {
    final jsonString =
        await rootBundle.rootBundle.loadString('lib/assets/data/countries.json');
    final Map<String, dynamic> countryData = json.decode(jsonString);
    setState(() {
      _countries = countryData[_selectedRegion] ?? [];
    });
  }

  void _onRegionChanged(String? value) {
    setState(() {
      _selectedRegion = value!;
      _selectedCountryCode = null;
      _selectedCountryName = null;
      _loadCountries();
      _checkInputFields();  // Recheck if the button should be active
    });
  }

  void _onCountryChanged(String? value) {
    setState(() {
      final selectedCountry =
          _countries.firstWhere((country) => country['code'] == value);
      _selectedCountryCode = selectedCountry['code'];
      _selectedCountryName = selectedCountry['name'];
      _checkInputFields();  // Recheck if the button should be active
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/signup.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  SizedBox(height: Platform.isIOS ? 100 : 60),  // Adjust for iOS
                  _buildCardWithBorderShadow(
                    child: Column(
                      children: [
                        Text(
                          'Create Your Account',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                color: Color(0xFF92432A).withOpacity(0.8),
                                offset: Offset(-4, -4),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                              BoxShadow(
                                color: Color(0xFF92432A).withOpacity(0.5),
                                offset: Offset(4, 4),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _fullNameTouched = true;
                            });
                          },
                          child: _buildTextField(
                              controller: _fullNameController,
                              labelText: 'Full Name',
                              errorMessage: _fullNameError),
                        ),
                        SizedBox(height: 16),
                        _buildRegionDropdown(),
                        SizedBox(height: 16),
                        _buildCountryDropdown(),
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _phoneNumberTouched = true;
                            });
                          },
                          child: _buildPhoneNumberField(),
                        ),
                        _buildErrorText(_phoneNumberError),
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _passwordTouched = true;
                            });
                          },
                          child: _buildPasswordField(),
                        ),
                        _buildErrorText(_passwordError),
                        SizedBox(height: 16),
                        _buildTermsAndConditions(),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _isButtonActive
                              ? () {
                                  Navigator.pushNamed(
                                    context,
                                    '/signup_verification',
                                    arguments: {
                                      'countryCode': _selectedCountryCode,
                                      'countryName': _selectedCountryName,
                                      'phoneNumber':
                                          _phoneNumberController.text,
                                    },
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            backgroundColor: _isButtonActive
                                ? Color(0xFF92432A)
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 10,
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardWithBorderShadow({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.transparent,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    String? errorMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF151211),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF92432A).withOpacity(0.8),
                offset: Offset(-4, -4),
                blurRadius: 10,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Color(0xFF92432A).withOpacity(0.5),
                offset: Offset(4, 4),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Color(0xFF151211),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
        if (errorMessage != null && _fullNameTouched)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }

  Widget _buildPhoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF151211),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF92432A).withOpacity(0.8),
                offset: Offset(-4, -4),
                blurRadius: 10,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Color(0xFF92432A).withOpacity(0.5),
                offset: Offset(4, 4),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              if (_selectedCountryCode != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$_selectedCountryCode',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              Expanded(
                child: TextField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter your phone number',
                    hintStyle: TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Color(0xFF151211),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF151211),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF92432A).withOpacity(0.8),
                offset: Offset(-4, -4),
                blurRadius: 10,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Color(0xFF92432A).withOpacity(0.5),
                offset: Offset(4, 4),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Color(0xFF151211),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildRegionDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF151211),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF92432A).withOpacity(0.8),
            offset: Offset(-4, -4),
            blurRadius: 10,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Color(0xFF92432A).withOpacity(0.5),
            offset: Offset(4, 4),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFF151211),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        value: _selectedRegion,
        items: ['Select Region', 'Asia', 'Europe', 'America', 'Africa', 'Oceania']
            .map((region) => DropdownMenuItem(
                  value: region,
                  child: Text(
                    region,
                    style: TextStyle(color: Colors.white),
                  ),
                ))
            .toList(),
        onChanged: _onRegionChanged,
        dropdownColor: Color(0xFF151211),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildCountryDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF151211),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF92432A).withOpacity(0.8),
            offset: Offset(-4, -4),
            blurRadius: 10,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Color(0xFF92432A).withOpacity(0.5),
            offset: Offset(4, 4),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFF151211),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        value: _selectedCountryCode,
        hint: Text(
          'Select Country',
          style: TextStyle(color: Colors.white),
        ),
        items: _countries.map((country) {
          return DropdownMenuItem<String>(
            value: country['code'],
            child: Text(
              '${country['name']}',
              style: TextStyle(color: Colors.white),
            ),
          );
        }).toList(),
        onChanged: _onCountryChanged,
        dropdownColor: Color(0xFF151211),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _termsAccepted,
          onChanged: (value) {
            setState(() {
              _termsAccepted = value!;
              _checkInputFields(); // Recheck if the button should be active
            });
          },
          activeColor: Color(0xFF92432A),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'I have read and accept the ',
              style: TextStyle(color: Colors.white, fontSize: 14),
              children: <TextSpan>[
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(color: Colors.purple, fontSize: 14),
                ),
                TextSpan(
                  text:
                      '. The information collected on this page is only used for account registration.',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorText(String? errorMessage) {
    return errorMessage != null
        ? Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          )
        : SizedBox.shrink();
  }
}
