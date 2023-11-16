import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class landingPage extends StatefulWidget {
  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    // final String assetName = 'images/90-ring-with-bg.svg';
    return Scaffold(
      body: Center(
        child: Image.asset(
          'images/Blue-Ride-ASU.png',
          width: 350.0,
          height: 350.0,
        ),
      ),
    );
  }
}
