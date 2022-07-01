import 'package:car_rental_ui/app/home/views/repository/auth_repository.dart';
import 'package:car_rental_ui/app/route/route_page.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sigup_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = new TextEditingController();

  final passwC = new TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // String errorMessage = '';
  AutRepository _user = AutRepository();

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
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        key: _key,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Login",
                          style: GoogleFonts.montserrat(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Login to your account",
                          style: GoogleFonts.montserrat(
                              fontSize: 15, color: Colors.grey[700]),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: emailC,
                            validator: validEmail,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: "Enter your e-mail",
                              labelText: "Email",
                              labelStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.normal),
                              hintStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          TextFormField(
                            controller: passwC,
                            obscureText: true,
                            validator: validPass,
                            decoration: InputDecoration(
                              hintText: "Enter your password",
                              labelText: "Password",
                              labelStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.normal),
                              hintStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.normal),
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
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            try {
                              _user
                                  .getDataUser(emailC.text, passwC.text)
                                  .then((value) {
                                if (value != null) {
                                  showNotif(context, "Login Succes");
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RoutePage()));
                                }
                              });
                              // errorMessage = '';
                            } on FirebaseAuthException catch (e) {
                              showNotif(context, e.message.toString());
                            }
                          }
                        },
                        color: Colors.grey,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Login",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account? "),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                          },
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? validEmail(String? emailC) {
  if (emailC == null || emailC.isEmpty) return 'Please enter your email ';

  String pattern = "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]";
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(emailC)) return 'Invalid email address format';

  return null;
}

String? validPass(String? passwC) {
  if (passwC == null || passwC.isEmpty) return 'Please enter your password ';

  if (passwC.length < 6) return 'Password too short';

  return null;
}

void showNotif(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: color4, content: Text(message.toString())));
}
