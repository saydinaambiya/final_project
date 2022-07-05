import 'package:car_rental_ui/app/screen/admin/contents/admin_content.dart';
import 'package:car_rental_ui/app/screen/admin/contents/manage_content.dart';
import 'package:car_rental_ui/app/screen/admin/contents/profile_content.dart';
import 'package:car_rental_ui/app/screen/admin/contents/transaction_content.dart';
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
    ProfileAdminPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: color4,
              labelTextStyle: MaterialStateProperty.all(GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color1,
              ))),
          child: NavigationBar(
              height: 60,
              backgroundColor: color4,
              selectedIndex: index,
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              destinations: [
                NavigationDestination(
                    icon: Icon(
                      FontAwesomeIcons.house,
                      color: color1,
                    ),
                    label: "Home"),
                NavigationDestination(
                    icon: Icon(
                      FontAwesomeIcons.car,
                      color: color1,
                    ),
                    label: "Cars"),
                NavigationDestination(
                    icon: Icon(
                      FontAwesomeIcons.receipt,
                      color: color1,
                    ),
                    label: "Transaction"),
                NavigationDestination(
                    icon: Icon(
                      FontAwesomeIcons.solidUser,
                      color: color1,
                    ),
                    label: "Profile"),
              ])),
    );
  }
}
