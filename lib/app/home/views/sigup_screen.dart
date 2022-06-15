import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_screen.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        height: MediaQuery.of(context).size.height - 50,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "Sign Up",
                  style: GoogleFonts.montserrat(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Create an account, It's free",
                  style: GoogleFonts.montserrat(
                      fontSize: 15, color: Colors.grey[700]),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Enter your full name",
                      labelText: "Full Name",
                      labelStyle:
                          GoogleFonts.montserrat(fontWeight: FontWeight.normal),
                      hintStyle:
                          GoogleFonts.montserrat(fontWeight: FontWeight.normal),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Enter your e-mail",
                      labelText: "Email",
                      labelStyle:
                          GoogleFonts.montserrat(fontWeight: FontWeight.normal),
                      hintStyle:
                          GoogleFonts.montserrat(fontWeight: FontWeight.normal),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Enter your phone number",
                      labelText: "Phone Number",
                      labelStyle:
                          GoogleFonts.montserrat(fontWeight: FontWeight.normal),
                      hintStyle:
                          GoogleFonts.montserrat(fontWeight: FontWeight.normal),
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      labelText: "Password",
                      labelStyle:
                          GoogleFonts.montserrat(fontWeight: FontWeight.normal),
                      hintStyle:
                          GoogleFonts.montserrat(fontWeight: FontWeight.normal),
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Confirm your password",
                      labelText: "Confirm Password",
                      labelStyle:
                          GoogleFonts.montserrat(fontWeight: FontWeight.normal),
                      hintStyle:
                          GoogleFonts.montserrat(fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                color: Colors.grey,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
