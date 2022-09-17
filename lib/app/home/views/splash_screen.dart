import 'dart:async';

import 'package:car_rental_ui/app/home/views/home_screen.dart';
import 'package:car_rental_ui/app/route/route_page.dart';
import 'package:car_rental_ui/app/screen/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      final User? user = _auth.currentUser;
      final uid = user?.uid;
      if (uid == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => OnboardingPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => RoutePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        width: 250,
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                'https://firebasestorage.googleapis.com/v0/b/final-project-b3526.appspot.com/o/images%2Flogo.png?alt=media&token=53507337-b3d4-4e2f-aaad-4017be5469f9'),
            SizedBox(
              height: 100,
              width: 100,
              child: Lottie.network(
                  'https://assets1.lottiefiles.com/packages/lf20_zvjwvszs.json'),
            )
          ],
        ),
      )),
    );
  }
}
