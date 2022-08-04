import 'package:car_rental_ui/app/screen/admin/contents/admin_content.dart';
import 'package:car_rental_ui/app/screen/admin/contents/manage_content.dart';
import 'package:car_rental_ui/app/screen/admin/contents/profile_content.dart';
import 'package:car_rental_ui/app/screen/admin/contents/transaction_content.dart';
import 'package:car_rental_ui/app/screen/user/user_profile.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPage extends StatefulWidget {
  AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int index = 0;
  final screens = [
    AdminHome(),
    ManagePage(),
    TransAdminPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: color1,
              labelTextStyle: MaterialStateProperty.all(GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: colorW,
              ))),
          child: NavigationBar(
              height: 60,
              backgroundColor: color1,
              selectedIndex: index,
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              destinations: [
                NavigationDestination(
                    icon: Icon(
                      FontAwesomeIcons.house,
                      color: colorW,
                    ),
                    label: "Home"),
                NavigationDestination(
                    icon: Icon(
                      FontAwesomeIcons.plus,
                      color: colorW,
                    ),
                    label: "Cars"),
                NavigationDestination(
                    icon: Icon(
                      FontAwesomeIcons.receipt,
                      color: colorW,
                    ),
                    label: "Transaction"),
                NavigationDestination(
                    icon: Icon(
                      FontAwesomeIcons.solidUser,
                      color: colorW,
                    ),
                    label: "Profile"),
              ])),
    );
  }
}
