import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

var size, height, width;

class CardItem extends StatelessWidget {
  const CardItem({
    required this.cid,
    required this.imageURl,
    required this.carName,
    required this.carBrand,
    required this.carYear,
    required this.price,
    required this.fuel,
    required this.nopol,
    required this.seater,
    required this.transmition,
    required this.status,
    required this.recomend,
    Key? key,
  }) : super(key: key);

  final String cid;
  final String imageURl;
  final String carName;
  final String carBrand;
  final String carYear;
  final String price;
  final String fuel;
  final String nopol;
  final String seater;
  final String transmition;
  final String status;
  final String recomend;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
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
                            child: Image.network(imageURl),
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
                              carBrand,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$carName $carYear',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp ',
                                    decimalDigits: 0,
                                  ).format(int.parse(price)),
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
                              linkImage:
                                  'https://firebasestorage.googleapis.com/v0/b/final-project-b3526.appspot.com/o/icons%2Flicense-plate.png?alt=media&token=3e8f696c-a61f-4ddd-be7a-370bbde318ee',
                              boxText: nopol),
                          SpecBox(
                            boxText: transmition,
                            linkImage:
                                'https://firebasestorage.googleapis.com/v0/b/final-project-b3526.appspot.com/o/icons%2Fsettings.png?alt=media&token=1bf064f4-5335-41ce-81bc-ffad53c76646',
                          ),
                          SpecBox(
                            boxText: fuel,
                            linkImage:
                                'https://firebasestorage.googleapis.com/v0/b/final-project-b3526.appspot.com/o/icons%2Ffuel.png?alt=media&token=9c47c495-7164-4a5b-b265-7cee472716da',
                          ),
                          SpecBox(
                            boxText: '$seater Seaters',
                            linkImage:
                                'https://firebasestorage.googleapis.com/v0/b/final-project-b3526.appspot.com/o/icons%2Fcar-seat.png?alt=media&token=65bc929e-844a-438d-aef1-6eeb88047b01',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 10),
        padding: EdgeInsets.only(
          left: 10,
        ),
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
            SizedBox(
                width: width / 2.7,
                height: height / 2,
                child: Image.network('$imageURl')),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 10,
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
                    nopol,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal, fontSize: 12),
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(int.parse(price)),
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
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            HeaderSettings(),
                            DividSettings(),
                            status == 'Used'
                                ? TextSettings(
                                    textcontent: "Mobil Tersedia",
                                    press: () {
                                      final docCar = FirebaseFirestore.instance
                                          .collection('cars')
                                          .doc(cid);
                                      docCar.update({'status': 'Available'});
                                      Navigator.of(context).pop();
                                    })
                                : TextSettings(
                                    textcontent: "Mobil Dipakai",
                                    press: () {
                                      final docCar = FirebaseFirestore.instance
                                          .collection('cars')
                                          .doc(cid);
                                      docCar.update({'status': 'Used'});
                                      Navigator.of(context).pop();
                                    }),
                            DividSettings(),
                            recomend == 'Yes'
                                ? TextSettings(
                                    textcontent: "Batalkan Rekomendasi",
                                    press: () {
                                      final docCar = FirebaseFirestore.instance
                                          .collection('cars')
                                          .doc(cid);
                                      docCar.update({'recomend': 'No'});
                                      Navigator.of(context).pop();
                                    })
                                : TextSettings(
                                    press: () {
                                      final docCar = FirebaseFirestore.instance
                                          .collection('cars')
                                          .doc(cid);
                                      docCar.update({'recomend': 'Yes'});
                                      Navigator.of(context).pop();
                                    },
                                    textcontent: "Rekomendasikan Mobil",
                                  ),
                            DividSettings(),
                            TextSettings(
                              press: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text('Hapus Mobil'),
                                          content: Text('Anda Yakin ?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('No'),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  final docCar =
                                                      FirebaseFirestore.instance
                                                          .collection('cars')
                                                          .doc(cid);
                                                  docCar.delete();
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Yes'))
                                          ],
                                        ));
                              },
                              textcontent: "Hapus Mobil",
                            ),
                            DividSettings(),
                          ],
                        );
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DividSettings extends StatelessWidget {
  const DividSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 2,
    );
  }
}

class TextSettings extends StatelessWidget {
  const TextSettings({
    required this.textcontent,
    required this.press,
    Key? key,
  }) : super(key: key);

  final String textcontent;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
              style: TextButton.styleFrom(primary: Colors.black),
              onPressed: press,
              child: Text(
                textcontent,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
    );
  }
}

class HeaderSettings extends StatelessWidget {
  const HeaderSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(FontAwesomeIcons.xmark)),
        Text(
          "Pengaturan",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

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
