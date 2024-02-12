// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weather/pages/homepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Simulate some initialization tasks or loading data
    await Future.delayed(Duration(milliseconds: 1200));

    // Navigate to the main screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(246, 0, 0, 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Loading...",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(height: 16.0),
            CircularProgressIndicator.adaptive(),
          ],
        ),
      ),
    );
  }
}
