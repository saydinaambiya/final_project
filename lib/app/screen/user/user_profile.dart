import 'package:car_rental_ui/app/home/models/user_model.dart';
import 'package:car_rental_ui/app/home/views/home_screen.dart';
import 'package:car_rental_ui/app/home/views/welcome_screen.dart';
import 'package:car_rental_ui/app/screen/onboarding_screen.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'widgets/setting_profile.dart';
import 'widgets/user_data.dart';

var size, height, width;

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    if (user != null) {
      super.initState();
      FirebaseFirestore.instance
          .collection("users")
          .doc(user?.uid)
          .get()
          .then((value) {
        this.loggedInUser = UserModel.fromMap(value.data());
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: user == null
            ? WelcomePage()
            // Center(
            //     child: Center(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           LottieBuilder.network(
            //             'https://lottie.host/0b60d908-d29a-4310-b8c1-c4ec52a36230/bBDFuKTsCk.json',
            //             height: 250,
            //             width: 250,
            //           ),
            //           Text(
            //             'Login Untuk Melihat Profile',
            //             style: GoogleFonts.montserrat(
            //                 color: color1, fontWeight: FontWeight.bold),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           MaterialButton(
            //             onPressed: () {
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => WelcomePage()));
            //             },
            //             child: Text(
            //               'Login',
            //               style: GoogleFonts.montserrat(
            //                 fontWeight: FontWeight.bold,
            //                 color: colorW,
            //               ),
            //             ),
            //             height: 30,
            //             color: color1,
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(5),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.montserrat(
                                fontSize: 24,
                                color: Colors.black87,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Profile",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: " "),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(FontAwesomeIcons.gear),
                            onPressed: () {
                              settingPopup(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 0.5,
                                    blurRadius: 10,
                                  )
                                ],
                                color: colorW,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(120),
                                  topRight: Radius.circular(120),
                                )),
                            margin: EdgeInsets.only(top: 100),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: height / 1.5,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height / 8),
                                UserData(
                                  title: "Full Name",
                                  value: "${loggedInUser.fullName}",
                                ),
                                UserData(
                                  title: "Email",
                                  value: "${loggedInUser.email}",
                                ),
                                UserData(
                                  title: "Password",
                                  value: "*******",
                                ),
                                UserData(
                                  title: "Phone / Whatsapp",
                                  value: "${loggedInUser.phoneNumber}",
                                ),
                                UserData(
                                  title: "Address",
                                  value: "${loggedInUser.address}",
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 50,
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.solidUser,
                                    size: 60,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorW,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 0.5,
                                        blurRadius: 10,
                                      )
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                  ),
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ],
                          ),
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
