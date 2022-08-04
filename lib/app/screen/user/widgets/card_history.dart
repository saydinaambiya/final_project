import 'package:car_rental_ui/app/home/views/home_screen.dart';
import 'package:car_rental_ui/app/home/views/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'modal_popup.dart';

var size, height, width;

class CardHistory extends StatefulWidget {
  final String carImage;
  final String carName;
  final String numTrans;
  final String carTotPrice;
  final String transStat;
  final String carDate;
  final String tid;
  final String cid;

  CardHistory({
    required this.carImage,
    required this.carName,
    required this.numTrans,
    required this.carTotPrice,
    required this.transStat,
    required this.carDate,
    required this.tid,
    required this.cid,
    Key? key,
  }) : super(key: key);

  @override
  State<CardHistory> createState() => _CardHistoryState(
        carImage,
        carName,
        numTrans,
        carTotPrice,
        transStat,
        carDate,
        tid,
        cid,
      );
}

class _CardHistoryState extends State<CardHistory> {
  String _carImage;
  String _carName;
  String _numTrans;
  String _carTotPrice;
  String _transStat;
  String _carDate;
  String _tid;
  String _cid;

  _CardHistoryState(
    this._carImage,
    this._carName,
    this._numTrans,
    this._carTotPrice,
    this._transStat,
    this._carDate,
    this._tid,
    this._cid,
  );
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.only(
        left: 10,
      ),
      height: height / 6,
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
            width: width / 2.5,
            height: width / 2,
            child: Image.network(
              _carImage,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _carName,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(int.parse(_carTotPrice)),
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.normal, fontSize: 12),
                ),
                Text(
                  _numTrans,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Text(
                  _carDate,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.normal, fontSize: 12),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 5,
                  ),
                  decoration: _transStat == "Selesai"
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.green[400],
                        )
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.amber[400],
                        ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      _transStat,
                      style: GoogleFonts.montserrat(fontSize: 10),
                    ),
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: IconButton(
              icon: Icon(FontAwesomeIcons.ellipsisVertical),
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(FontAwesomeIcons.xmark),
                              ),
                              Text(
                                "Lainnya",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          BreakLine(),
                          TextModal(
                            text: "Download Invoice",
                            tap: () {
                              Navigator.pop(context);
                              showNotif(context, "Coming Soon!");
                            },
                          ),
                          BreakLine(),
                          TextModal(
                            text: "Batalkan Pesanan",
                            tap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text('Batalkan Pesanan'),
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
                                                final docTrans =
                                                    FirebaseFirestore.instance
                                                        .collection('trans')
                                                        .doc(_tid);
                                                docTrans.update(
                                                    {'status': "Dibatalkan"});
                                                final docCar = FirebaseFirestore
                                                    .instance
                                                    .collection('cars')
                                                    .doc(_cid);
                                                docCar.update(
                                                    {'status': "Available"});
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomeScreen()));
                                              },
                                              child: Text('Yes'))
                                        ],
                                      ));
                            },
                          ),
                          BreakLine(),
                          // TextModal(
                          //   text: "Pesan Lagi",
                          //   tap: () {},
                          // ),
                          // BreakLine(),
                          TextModal(
                            text: "Hubungi",
                            tap: () {
                              Navigator.pop(context);
                              showNotif(context, "Coming Soon!");
                            },
                          ),
                          BreakLine(),
                        ],
                      );
                    });
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
  const TextModal({
    Key? key,
    required this.text,
    required this.tap,
  }) : super(key: key);

  final String text;
  final void Function() tap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 17,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
            style: TextButton.styleFrom(
                primary: Colors.black,
                textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
            onPressed: tap,
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
