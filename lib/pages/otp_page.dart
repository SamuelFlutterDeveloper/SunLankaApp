import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'package:sun_lunka_app/pages/customs/colors.dart';
import 'package:sun_lunka_app/pages/username.dart';
//import 'home.dart';
// Ensure the correct import path

class Otp extends StatefulWidget {
  final String phone;
  final String countryCode;

  const Otp({Key? key, required this.countryCode, required this.phone})
      : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: const Color.fromARGB(255, 255, 255, 255),
      // borderRadius: BorderRadius.circular(50),
      border: Border.all(color: Color.fromARGB(255, 223, 211, 211)),
      // boxShadow: [
      //   const BoxShadow(
      //     color: Color(0xffd9d9d9),
      //     spreadRadius: 5,
      //     blurRadius: 7,
      //     offset: Offset(0, 3),
      //   ),
      // ],
    ),
  );

  bool isPinComplete = false;
  String pin = "";

  String formatPhoneNumber(String phone, String countryCode) {
    if (phone.length < 3) {
      return '$countryCode $phone';
    }
    String maskedNumber =
        '*' * (phone.length - 2) + phone.substring(phone.length - 2);
    return '$countryCode $maskedNumber';
  }

  @override
  Widget build(BuildContext context) {
    String formattedPhoneNumber =
        formatPhoneNumber(widget.phone, widget.countryCode);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/otp.png'), fit: BoxFit.fill),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    screenWidth * 0.1, // Horizontal padding for responsiveness
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.45),
                  Text(
                    "Otp\nVerfication",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'We have to send the code\nVerfication to $formattedPhoneNumber',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 233, 255, 33),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Pinput(
                    length: 4,
                    obscureText: true,
                    obscuringCharacter: '*',
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(
                          color: Mycolor.TextColor,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        pin = value;
                        isPinComplete = value.length == 4;
                        print("${pin}----------------------------------------");
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't get code",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'RECENT!',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 233, 255, 33),
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: isPinComplete
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Username()),
                            );
                          }
                        : null,
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27),
                        color: isPinComplete
                            ? Mycolor.ButtonColor
                            : Mycolor.ButtonColor,
                      ),
                      child: const Center(
                        child: Text(
                          'Verify Otp',
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
      ),
    );
  }
}
