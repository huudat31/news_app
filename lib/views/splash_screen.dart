import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_a/views/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/splash_pic.jpg',
              fit: BoxFit.cover,
              height: height * 0.5,
              width: width * .9,
            ),
            SizedBox(
              height: height * .04,
            ),
            Text(
              "Top HEADLINES",
              style: GoogleFonts.anton(
                letterSpacing: .6,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(
              height: height * .04,
            ),
            SpinKitChasingDots(
              color: Colors.blue,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}
