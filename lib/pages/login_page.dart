import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sun_lunka_app/pages/customs/colors.dart';
import 'package:sun_lunka_app/pages/otp_page.dart';

// Validator class for mobile number validation
class Validator {
  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Mobile number';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return "Please Enter a valid mobile number";
    }
    return null;
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phoneNumber = '';
  String selectedCountryCode = 'LK';
  final _formKey = GlobalKey<FormState>(); // Key for the form

  @override
  void initState() {
    super.initState();
    _loadPhoneNumber(); // Load phone number when the widget is initialized
  }

  Future<void> _loadPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      phoneNumber = prefs.getString('phone_number') ?? '';
    });
    print("$phoneNumber phone number save in local");
  }

  Future<void> _savePhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone_number', phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    screenWidth * 0.1, // Horizontal padding for responsiveness
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.45),
                    Text(
                      'Let\'s Connect',
                      style: TextStyle(
                          fontSize: screenWidth * 0.08, // Responsive font size
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Together',
                      style: TextStyle(
                          fontSize: screenWidth * 0.08, // Responsive font size
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Please enter the 9-digit phone number",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 233, 255, 33),
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04), // Adjust text size
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 55,
                      width: screenWidth * 0.8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border:
                              Border.all(color: Colors.grey.shade300, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: IntlPhoneField(
                            disableLengthCheck: true,
                            initialCountryCode: 'LK',
                            decoration: InputDecoration(
                              hintText: "enter your phone number",
                              border: InputBorder
                                  .none, // Remove the default border of the text field
                            ),
                            onChanged: (phone) {
                              setState(() {
                                phoneNumber = phone
                                    .number; // Store the phone number (10 digits)
                                selectedCountryCode = phone.countryCode;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Spacer(), // Push content to center
                    GestureDetector(
                      onTap: () async {
                        // Check if the phone number is exactly 9 digits
                        if (phoneNumber.length == 9 &&
                            RegExp(r'^\d{9}$').hasMatch(phoneNumber)) {
                          // Save the phone number locally
                          await _savePhoneNumber();
                          print(
                              "$phoneNumber--------------------------------------");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Otp(
                                countryCode: selectedCountryCode,
                                phone: '$selectedCountryCode$phoneNumber',
                              ),
                            ),
                          );
                        } else {
                          // Show an error message if validation fails
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Color.fromARGB(255, 173, 30, 20),
                              content: Text(
                                'Please enter a valid 9-digit phone number.',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 55,
                        width: screenWidth * 0.8, // Responsive width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(27),
                          color: phoneNumber.length == 9 &&
                                  RegExp(r'^\d{9}$').hasMatch(phoneNumber)
                              ? Mycolor.ButtonColor
                              : Colors
                                  .grey, // Change color if phone number is valid
                        ),
                        child: const Center(
                          child: Text(
                            'Get OTP',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                        height: screenHeight * 0.05), // Spacing from bottom
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
