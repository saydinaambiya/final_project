import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

var size, height, width;

class ItemDetails extends StatefulWidget {
  ItemDetails({Key? key}) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: height / 3,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 0.5,
                        blurRadius: 5,
                      )
                    ],
                    color: colorW,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Car Details",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                        InkWell(
                          child: Icon(FontAwesomeIcons.xmark),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: height / 4,
                      width: double.infinity,
                      child: Image.asset("assets/images/veloz2019.png"),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 20,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Toyota",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Avanza Veloz 2019",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: width / 8,
                          ),
                          Text(
                            "Rp. 350.000/Hari",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SpecBox(
                      boxText: 'Manual',
                      linkImage:
                          'https://firebasestorage.googleapis.com/v0/b/final-project-b3526.appspot.com/o/icons%2Fsettings.png?alt=media&token=1bf064f4-5335-41ce-81bc-ffad53c76646',
                    ),
                    SpecBox(
                      boxText: 'Bensin',
                      linkImage:
                          'https://firebasestorage.googleapis.com/v0/b/final-project-b3526.appspot.com/o/icons%2Ffuel.png?alt=media&token=9c47c495-7164-4a5b-b265-7cee472716da',
                    ),
                    SpecBox(
                      boxText: '7 Seaters',
                      linkImage:
                          'https://firebasestorage.googleapis.com/v0/b/final-project-b3526.appspot.com/o/icons%2Fcar-seat.png?alt=media&token=65bc929e-844a-438d-aef1-6eeb88047b01',
                    ),
                    SpecBox(
                        linkImage:
                            'https://firebasestorage.googleapis.com/v0/b/final-project-b3526.appspot.com/o/icons%2Flicense-plate.png?alt=media&token=3e8f696c-a61f-4ddd-be7a-370bbde318ee',
                        boxText: 'BL 123 XX')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> itemDetails(BuildContext context) => showModalBottomSheet(
    context: context,
    builder: (context) {
      size = MediaQuery.of(context).size;
      height = size.height;
      width = size.width;

      return Column(
        children: [
          Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: height / 3,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0.5,
                      blurRadius: 5,
                    )
                  ],
                  color: colorW,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Car Details",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      InkWell(
                        child: Icon(FontAwesomeIcons.xmark),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: height / 4,
                    width: double.infinity,
                    child: Image.asset("assets/images/veloz2019.png"),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 20,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Toyota",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Avanza Veloz 2019",
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: width / 8,
                        ),
                        Text(
                          "Rp. 350.000/Hari",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SpecBox(
                    boxText: 'Manual',
                    linkImage:
                        'https://firebasestorage.googleapis.com/v0/b/final-project-b3526.appspot.com/o/icons%2Fsettings.png?alt=media&token=1bf064f4-5335-41ce-81bc-ffad53c76646',
                  ),
                  SpecBox(
                    boxText: 'Bensin',
                    linkImage:
                        'https://firebasestorage.googleapis.com/v0/b/final-project-b3526.appspot.com/o/icons%2Ffuel.png?alt=media&token=9c47c495-7164-4a5b-b265-7cee472716da',
                  ),
                  SpecBox(
                    boxText: '7 Seaters',
                    linkImage:
                        'https://firebasestorage.googleapis.com/v0/b/final-project-b3526.appspot.com/o/icons%2Fcar-seat.png?alt=media&token=65bc929e-844a-438d-aef1-6eeb88047b01',
                  ),
                  SpecBox(
                      linkImage:
                          'https://firebasestorage.googleapis.com/v0/b/final-project-b3526.appspot.com/o/icons%2Flicense-plate.png?alt=media&token=3e8f696c-a61f-4ddd-be7a-370bbde318ee',
                      boxText: 'BL 123 XX')
                ],
              ),
            ),
          ),
        ],
      );
    });

class SpecBox extends StatelessWidget {
  const SpecBox({
    required this.linkImage,
    required this.boxText,
    Key? key,
  }) : super(key: key);

  final String linkImage;
  final String boxText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      height: height / 10,
      width: width / 3,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.5,
            blurRadius: 1,
          )
        ],
        color: color1,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              linkImage,
              height: 30,
              width: 30,
              color: colorW,
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: colorW,
                  fontWeight: FontWeight.w500,
                ),
                children: <TextSpan>[
                  TextSpan(text: boxText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
