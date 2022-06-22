import 'package:car_rental_ui/app/home/models/user_model.dart';
import 'package:car_rental_ui/app/home/views/home_screen.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  //editing C
  final nameC = new TextEditingController();
  final emailC = new TextEditingController();
  final phoneC = new TextEditingController();
  final passwC = new TextEditingController();
  final passwconfrmC = new TextEditingController();

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
                    controller: nameC,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      RegExp regex = new RegExp(r'^.{3,}$');
                      if (value!.isEmpty) {
                        return ("Full Name is Required for Sign Up");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Please Enter Valid Name (Min. 3 Characters)");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      nameC.text = value!;
                    },
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
                    controller: emailC,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter Your Email");
                      }
                      // reg expression for email validation
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please Enter a Valid Email");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      emailC.text = value!;
                    },
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
                    controller: phoneC,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      String pattern = r'(^[0-9]*$)';
                      RegExp regex = new RegExp(pattern);
                      if (value!.isEmpty) {
                        return ("Phone Number is Required for Sign Up");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Please Enter Valid Phone Number");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      phoneC.text = value!;
                    },
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
                    controller: passwC,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    // validator: (value) {
                    //   RegExp regex = new RegExp(r'^.{6,}$');
                    //   if (value!.isEmpty) {
                    //     return ("Password is Required for Sign Up");
                    //   }
                    //   if (!regex.hasMatch(value)) {
                    //     return ("Please Enter Valid Password (Min. 6 Characters)");
                    //   }
                    // },
                    onSaved: (value) {
                      passwC.text = value!;
                    },
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
                    controller: passwconfrmC,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty)
                        return 'Please re-enter your password';
                      if (value != passwC.text) return 'Not Match';
                      return null;
                    },
                    onSaved: (value) {
                      passwconfrmC.text = value!;
                    },
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
                onPressed: () async {
                  await _auth
                      .createUserWithEmailAndPassword(
                          email: emailC.text, password: passwC.text)
                      .then((value) => {postDetailsToFirestore()})
                      .catchError((e) {
                    Fluttertoast.showToast(msg: e!.message);
                  });
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

  // void signUp(String email, String password) async {
  //   if (_formKey.currentState!.validate()) {
  //     await _auth
  //         .createUserWithEmailAndPassword(email: email, password: password)
  //         .then((value) => {postDetailsToFirestore()})
  //         .catchError((e) {
  //       Fluttertoast.showToast(msg: e!.message);
  //     });
  //   }
  // }

  postDetailsToFirestore() async {
    //calling our firestore
    //calling our user model
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    //writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullName = nameC.text;
    userModel.phoneNumber = phoneC.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Your Account Created Successfully");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }

  void showNotif(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: color4, content: Text(message.toString())));
  }
}
