import 'package:car_rental_ui/app/screen/detail_cars/detail_cars.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

var size, height, width;

class CarItem extends StatelessWidget {
  const CarItem({
    required this.idC,
    required this.carName,
    required this.carYear,
    required this.imageLink,
    required this.carPrice,
    required this.carFuel,
    required this.carSeater,
    required this.carTransmition,
    required this.carBrand,
    required this.carPlat,
    Key? key,
  }) : super(key: key);

  final String idC;
  final String imageLink;
  final String carName;
  final String carYear;
  final String carPrice;
  final String carSeater;
  final String carTransmition;
  final String carFuel;
  final String carBrand;
  final String carPlat;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Container(
      width: double.infinity,
      height: height / 5.90,
      padding: EdgeInsets.only(
        left: 20,
        top: 10,
        bottom: 10,
        right: 20,
      ),
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
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
            width: 150,
            height: 180,
            child: Image.network(
              imageLink,
              fit: BoxFit.contain,
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                carName,
                style: GoogleFonts.montserrat(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                carYear,
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
                  children: <TextSpan>[
                    TextSpan(
                        text: NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(int.parse(carPrice))),
                    TextSpan(
                        text: ' / Hari',
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailCars(
                            carId: idC,
                            imageUrl: imageLink,
                            name: carName,
                            year: carYear,
                            fuel: carFuel,
                            price: carPrice,
                            seaters: carSeater,
                            transmition: carTransmition,
                            nopol: carPlat,
                          )));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
