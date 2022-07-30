import 'package:car_rental_ui/app/home/models/user_model.dart';
import 'package:car_rental_ui/app/home/views/home_screen.dart';
import 'package:car_rental_ui/app/home/views/login_screen.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  //Controller
  final nameC = new TextEditingController();
  final emailC = new TextEditingController();
  final phoneC = new TextEditingController();
  final addressC = new TextEditingController();
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
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height - 150,
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
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: nameC,
                      validator: validName,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Enter your full name",
                        labelText: "Full Name",
                        labelStyle: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal),
                        hintStyle: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal),
                      ),
                    ),
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
                      controller: phoneC,
                      validator: validPhone,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Enter your phone number",
                        labelText: "Phone Number",
                        labelStyle: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal),
                        hintStyle: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    TextFormField(
                      controller: addressC,
                      validator: validAddress,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Enter your address",
                        labelText: "Address",
                        labelStyle: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal),
                        hintStyle: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    TextFormField(
                      controller: passwC,
                      validator: validPass,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
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
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () {
                  signUp(emailC.text, passwC.text);
                },
                color: color1,
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

  void showNotif(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: color1, content: Text(message.toString())));
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        showNotif(context, e.message.toString());
      });
    }
  }

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
    userModel.address = addressC.text;
    userModel.level = "user";

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    showNotif(context, "Registration is Success");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }
}

String? validName(String? nameC) {
  if (nameC == null || nameC.isEmpty) return 'Please enter your name';
  String pattern = r'^.{3,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(nameC)) return 'Please enter min. 3 characters';
  return null;
}

String? validPhone(String? phoneC) {
  if (phoneC == null || phoneC.isEmpty) return 'Please enter your phone number';
  String pattern = r'(^[0-9]*$)';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(phoneC)) return 'Please enter valid phone number';
  return null;
}

String? validAddress(String? addressC) {
  if (addressC == null || addressC.isEmpty) return 'Please enter your address';
  String pattern = r'^.{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(addressC)) return 'Please enter valid address';
  return null;
}
