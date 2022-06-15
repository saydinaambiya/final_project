import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/setting_profile.dart';
import 'widgets/user_data.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                            style: TextStyle(fontWeight: FontWeight.bold)),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(120),
                          topRight: Radius.circular(120),
                        )),
                    margin: EdgeInsets.only(top: 100),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 500,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 100),
                        UserData(
                          title: "Full Name",
                          value: "Saydina Ambiya",
                        ),
                        UserData(
                          title: "Email",
                          value: "saydina@email.com",
                        ),
                        UserData(
                          title: "Password",
                          value: "*******",
                        ),
                        UserData(
                          title: "Phone / Whatsapp",
                          value: "085156307564",
                        ),
                        UserData(
                          title: "Address",
                          value: "Lhokseumawe",
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
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0.5,
                                blurRadius: 10,
                              )
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(60)),
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
    );
  }
}
