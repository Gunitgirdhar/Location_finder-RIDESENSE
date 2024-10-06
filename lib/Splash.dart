import 'package:flutter/material.dart';
import 'package:intern_gmap/First_Page.dart';
import 'dart:async';

class MSplashScreen extends StatefulWidget {
  @override
  _MSplashScreenState createState() => _MSplashScreenState();
}

class _MSplashScreenState extends State<MSplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start a timer for 2 seconds
    Timer(Duration(seconds: 2), () {
      // Navigate to the LocationInputPage after the timer completes
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LocationInputPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // You can change the background color
      body: Center(
        child: Text(
          'Location Finder',
          style: TextStyle(
            fontSize: 32, // Adjust the font size
            color: Colors.white, // Change the text color
            fontWeight: FontWeight.bold, // Bold text
          ),
        ),
      ),
    );
  }
}
