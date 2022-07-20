import 'package:car_rental_ui/app/home/views/cars_recom.dart';
import 'package:car_rental_ui/app/home/widgets/home_content.dart';
import 'package:car_rental_ui/app/screen/user/user_history.dart';
import 'package:car_rental_ui/app/screen/user/user_profile.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final screens = [
    HomeContent(),
    CarsRecom(),
    UserHistory(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorW,
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
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: [
            NavigationDestination(
              icon: Icon(
                FontAwesomeIcons.house,
                color: colorW,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                FontAwesomeIcons.solidThumbsUp,
                color: colorW,
              ),
              label: 'Recommend',
            ),
            NavigationDestination(
              icon: Icon(
                FontAwesomeIcons.solidFileLines,
                color: colorW,
              ),
              label: 'Transactions',
            ),
            NavigationDestination(
              icon: Icon(
                FontAwesomeIcons.solidUser,
                color: colorW,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
