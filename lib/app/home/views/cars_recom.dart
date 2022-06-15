import 'package:car_rental_ui/app/home/widgets/cars_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                            color: Colors.black87,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                                text: 'Recommended',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' Cars'),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.list),
                        onPressed: () {
                          print("Search");
                        },
                      ),
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
