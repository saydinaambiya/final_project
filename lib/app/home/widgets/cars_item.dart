import 'package:car_rental_ui/app/screen/detail_cars/detail_cars.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CarItem extends StatelessWidget {
  const CarItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
      padding: EdgeInsets.only(
        left: 10,
        top: 10,
        bottom: 10,
        right: 10,
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 0.5,
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 170,
            height: 180,
            child: Image.asset(
              "assets/images/innova.png",
              fit: BoxFit.contain,
              // color: Colors.amber,
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Innova Reborn",
                style: GoogleFonts.montserrat(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "2022",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  children: const <TextSpan>[
                    TextSpan(text: '\Rp 350.000 '),
                    TextSpan(
                        text: '/ Hari',
                        style: TextStyle(color: Colors.black38)),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: color1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Details"),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(FontAwesomeIcons.arrowRight),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DetailCars()));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
