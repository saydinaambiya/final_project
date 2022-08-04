import 'dart:async';

import 'package:car_rental_ui/app/home/views/welcome_screen.dart';
import 'package:car_rental_ui/app/route/route_page.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      final User? user = _auth.currentUser;
      final uid = user?.uid;
      if (uid == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomePage()));
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
        height: 300,
        child: Column(
          children: [
            Image.network(
                'https://firebasestorage.googleapis.com/v0/b/final-project-b3526.appspot.com/o/images%2Flogo.png?alt=media&token=53507337-b3d4-4e2f-aaad-4017be5469f9'),
            CircularProgressIndicator(
              color: color1,
            ),
          ],
        ),
      )),
    );
  }
}
