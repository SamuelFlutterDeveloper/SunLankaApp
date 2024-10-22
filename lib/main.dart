import 'package:flutter/material.dart';


import 'package:sun_lunka_app/pages/splash_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
