import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:genz/home_page.dart';  // Importing the home page

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  bool _usePasswordLogin = false; // To toggle between login methods
  String? _selectedCountry;
  String _countryCode = '+1'; // Default country code
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<Map<String, dynamic>> _countries = []; // Country list to store name and dial codes

  String? _phoneError;
  String? _passwordError;
  String? _countryError;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    try {
      // Load the countries.json file
      final String response = await rootBundle.loadString('lib/assets/data/countries.json');
      final data = json.decode(response);

      // Flatten the countries list from multiple continents
      List<Map<String, dynamic>> countriesList = [];
      data.forEach((continent, countries) {
        countriesList.addAll(List<Map<String, dynamic>>.from(countries));
      });

      setState(() {
        _countries = countriesList;
        _selectedCountry = null; // Initially no country selected
      });

      print("Loaded countries: $_countries"); // Debugging the countries list
    } catch (e) {
      print("Error loading countries: $e");
    }
  }

  void _validateInput() {
    setState(() {
      _countryError = _selectedCountry == null ? 'Please select a country' : null;
      _phoneError = _phoneController.text.isEmpty ? 'Please enter your phone number' : null;
      if (_usePasswordLogin) {
        _passwordError = _passwordController.text.isEmpty ? 'Please enter your password' : null;
      } else {
        _passwordError = null;
      }
    });
  }

  void _login() {
    _validateInput();

    if (_countryError == null && _phoneError == null && (_passwordError == null || !_usePasswordLogin)) {
      if (_usePasswordLogin) {
        Navigator.pushNamed(context, '/chatlist');
      } else {
        Navigator.pushNamed(
          context,
          '/login_verification',
          arguments: {
            'countryCode': _countryCode,
            'countryName': _selectedCountry,
            'phoneNumber': _phoneController.text,
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(  // Adding the back button
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(  // Navigate to home_page when back is pressed
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    color: Colors.black.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    shadowColor: Color(0xFFBE5E1D).withOpacity(0.6),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            _usePasswordLogin ? 'Login with Password' : 'Login with Mobile Number',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                BoxShadow(
                                  color: Color(0xFFBE5E1D).withOpacity(0.7),
                                  offset: Offset(-3, -3),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  offset: Offset(3, 3),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          // Country Dropdown without Dial Code (Always show this)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFBE5E1D).withOpacity(0.6),
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
                            child: DropdownButtonFormField<String>(
                              value: _selectedCountry,
                              decoration: InputDecoration(
                                labelText: 'Select Country',
                                labelStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Colors.black.withOpacity(0.6),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                                errorText: _countryError,
                              ),
                              hint: Text(
                                'Select Country', // Show "Select Country" initially
                                style: TextStyle(color: Colors.white),
                              ),
                              items: _countries.isNotEmpty
                                  ? _countries.map<DropdownMenuItem<String>>((country) {
                                      return DropdownMenuItem<String>(
                                        value: country['name'],
                                        child: Text(
                                          country['name'], // Only showing country name here
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    }).toList()
                                  : [
                                      DropdownMenuItem(
                                        child: Text('Loading...', style: TextStyle(color: Colors.white)),
                                      ),
                                    ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedCountry = value;
                                  _countryCode = _countries
                                      .firstWhere((country) => country['name'] == value)['code'];
                                });
                              },
                              dropdownColor: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          // Phone Number with Country Code (Always shown)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFBE5E1D).withOpacity(0.6),
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
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                prefixText: '$_countryCode ',
                                labelText: 'Enter your phone number',
                                labelStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Colors.black.withOpacity(0.6),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                                errorText: _phoneError,
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 20),
                          // Password field with show/hide toggle (Only show when using password login)
                          if (_usePasswordLogin)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFBE5E1D).withOpacity(0.6),
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
                                controller: _passwordController,
                                obscureText: !_showPassword,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: Colors.white),
                                  filled: true,
                                  fillColor: Colors.black.withOpacity(0.6),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _showPassword ? Icons.visibility : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _showPassword = !_showPassword;
                                      });
                                    },
                                  ),
                                  errorText: _passwordError,
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFBE5E1D),
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text('Login'),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _usePasswordLogin = !_usePasswordLogin;
                              });
                            },
                            child: Text(
                              _usePasswordLogin
                                  ? 'Back to login with code'
                                  : 'Login with Password',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
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
}
