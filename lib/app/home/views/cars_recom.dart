import 'package:car_rental_ui/app/home/widgets/cars_item.dart';
import 'package:car_rental_ui/app/home/widgets/search_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CarsRecom extends StatefulWidget {
  CarsRecom({Key? key}) : super(key: key);

  @override
  State<CarsRecom> createState() => _CarsRecomState();
}

class _CarsRecomState extends State<CarsRecom> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SearchButton(
            text1: "Recommended ",
            text2: "Cars",
            iconData: FontAwesomeIcons.list,
            onTapped: () {
              print("Iya udah ditekan");
            },
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: 5,
                  //     itemBuilder: (context, index) {
                  //       return CarItem(,);
                  //     },
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
