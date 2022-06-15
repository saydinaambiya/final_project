import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'search_button.dart';
import 'brand_list.dart';
import 'package:car_rental_ui/constants/text_constants.dart';
import 'cars_item.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SearchButton(
            text1: "Rental",
            text2: " App",
            iconData: FontAwesomeIcons.magnifyingGlass,
          ),
          BrandList(),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Available cars",
                        style: TextConstants.titleSection,
                      ),
                      IconButton(
                        onPressed: () {
                          print("filter cars");
                        },
                        icon: Icon(FontAwesomeIcons.list),
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return CarItem();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
