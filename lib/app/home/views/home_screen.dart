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
      backgroundColor: color1,
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: Colors.grey[200],
            labelTextStyle: MaterialStateProperty.all(GoogleFonts.montserrat(
                fontSize: 12, fontWeight: FontWeight.w500))),
        child: NavigationBar(
          height: 60,
          backgroundColor: Colors.grey[200],
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: [
            NavigationDestination(
              icon: Icon(FontAwesomeIcons.house),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(FontAwesomeIcons.solidThumbsUp),
              label: 'Recommend',
            ),
            NavigationDestination(
              icon: Icon(FontAwesomeIcons.solidFileLines),
              label: 'Transactions',
            ),
            NavigationDestination(
              icon: Icon(FontAwesomeIcons.solidUser),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
