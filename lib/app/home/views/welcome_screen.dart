import 'package:car_rental_ui/app/home/views/login_screen.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'sigup_screen.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  // Text(
                  //   "Welcome",
                  //   style: GoogleFonts.montserrat(
                  //       fontSize: 30,
                  //       fontWeight: FontWeight.bold,
                  //       color: color1),
                  // ),
                  SizedBox(
                    height: 50,
                  ),
                  Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/final-project-b3526.appspot.com/o/images%2Flogo.png?alt=media&token=53507337-b3d4-4e2f-aaad-4017be5469f9'),
                ],
              ),
              Column(
                children: <Widget>[
                  //login button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: color1),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "Login",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: color1),
                    ),
                  ),

                  //signup button
                  SizedBox(height: 20),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    color: color1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: colorW),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
