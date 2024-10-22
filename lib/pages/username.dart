import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:sun_lunka_app/pages/customs/colors.dart';
import 'package:sun_lunka_app/pages/location/current_location_page.dart';

class Username extends StatefulWidget {
  const Username({super.key});

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loademail();
  }

  // Load the stored username if it exists
  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    if (storedUsername != null) {
      _usernameController.text = storedUsername;
    }
    print("StoredUsername:-------------------------- $storedUsername");
  }

  // Save the username locally
  void _saveUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    print(
        "Username saved:------------------------------ ${_usernameController.text}");
  }

  void _saveemail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _emailController.text);
    print(
        "Email saved:------------------------------ ${_emailController.text}");
  }

  // Load the stored email if it exists
  void _loademail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedemail = prefs.getString('email');
    if (storedemail != null) {
      _emailController.text = storedemail;
    }
    print("StoredEmail:-------------------------- $storedemail");
  }

  // Validator methods
  static String? notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "Field cannot be empty";
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return "Only alphabetic characters are allowed";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an Email Id';
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/mobile number.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.45),
                Text(
                  'Register',
                  style: TextStyle(
                      fontSize: 35,
                      color: Mycolor.ButtonColor,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(
                    controller: _usernameController,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Mycolor.TextColor,
                      ),
                      hintText: 'Enter your username',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(
                    controller: _emailController,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Mycolor.TextColor,
                      ),
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    String? usernameValidationResult =
                        notEmpty(_usernameController.text);
                    String? emailValidationResult =
                        validateEmail(_emailController.text);

                    if (usernameValidationResult != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(usernameValidationResult),
                          backgroundColor:
                              const Color.fromARGB(255, 158, 11, 0),
                        ),
                      );
                    } else if (emailValidationResult != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(emailValidationResult),
                          backgroundColor:
                              const Color.fromARGB(255, 158, 11, 0),
                        ),
                      );
                    } else {
                      // Save the username and email, then navigate to the next screen
                      _saveUsername();
                      _saveemail();
                      print(
                          "Entered Username:------------------------ ${_usernameController.text}");
                      print(
                          "Entered Email:------------------------ ${_emailController.text}");
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Location()),
                          (route) => false);
                    }
                  },
                  child: Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Mycolor.ButtonColor,
                        borderRadius: BorderRadius.circular(27)),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
