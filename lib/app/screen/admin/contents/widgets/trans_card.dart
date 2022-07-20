import 'package:car_rental_ui/app/home/views/welcome_screen.dart';
import 'package:car_rental_ui/app/screen/user/widgets/modal_popup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class TransCard extends StatelessWidget {
  const TransCard({
    required this.imageURl,
    required this.carName,
    required this.carYear,
    required this.price,
    Key? key,
  }) : super(key: key);

  final String imageURl;
  final String carName;
  final String carYear;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 10),
      padding: EdgeInsets.only(left: 10, right: 10),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 0.5,
              blurRadius: 10,
            )
          ]
          // border: Border.all(width: 1, color: Colors.black),
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 155, height: 160, child: Image.network('$imageURl')),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  carName,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  carYear,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.normal, fontSize: 12),
                ),
                Text(
                  price,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: IconButton(
              icon: Icon(FontAwesomeIcons.ellipsisVertical),
              onPressed: () {
                modalPopup(context);
              },
            ),
          )
        ],
      ),
    );
  }
}

class BreakLine extends StatelessWidget {
  const BreakLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 2,
    );
  }
}

class TextModal extends StatelessWidget {
  const TextModal({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 17,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => WelcomePage()));
            },
            child: Text(
              text,
              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
