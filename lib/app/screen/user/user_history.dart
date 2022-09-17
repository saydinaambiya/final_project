import 'package:car_rental_ui/app/home/views/home_screen.dart';
import 'package:car_rental_ui/app/home/views/welcome_screen.dart';
import 'package:car_rental_ui/app/home/widgets/search_button.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'widgets/card_history.dart';

class UserHistory extends StatefulWidget {
  @override
  State<UserHistory> createState() => _UserHistoryState();
}

String status = "Selesai";

class _UserHistoryState extends State<UserHistory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FirebaseAuth.instance.currentUser == null
          ? Center(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.network(
                      'https://lottie.host/8539775f-122d-43a2-824a-16d292d4a04c/OPRh6rb2hD.json',
                      height: 250,
                      width: 250,
                    ),
                    Text(
                      'Login Untuk Melihat Transaksi',
                      style: GoogleFonts.montserrat(
                          color: color1, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomePage()));
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: colorW,
                        ),
                      ),
                      height: 30,
                      color: color1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SearchButton(
                    text1: "Transactions",
                    text2: "",
                    iconData: FontAwesomeIcons.list,
                    onTapped: () {
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
                                      "Filter Transaksi",
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                BreakLine(),
                                TextModal(
                                  text: "Dikonfirmasi",
                                  tap: () {
                                    setState(() {
                                      status = "Dikonfirmasi";
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                BreakLine(),
                                TextModal(
                                  text: "Dibatalkan",
                                  tap: () {
                                    setState(() {
                                      status = "Dibatalkan";
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                BreakLine(),
                                TextModal(
                                  text: "Diproses",
                                  tap: () {
                                    setState(() {
                                      status = "Diproses";
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                BreakLine(),
                                TextModal(
                                  text: "Selesai",
                                  tap: () {
                                    setState(() {
                                      status = "Selesai";
                                      Navigator.pop(context);
                                    });
                                  },
                                ),
                                BreakLine(),
                              ],
                            );
                          });
                    },
                  ),
                  StreamBuilder<List<Trans>>(
                    stream: readTrans(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else if (snapshot.data!.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: Lottie.network(
                                    'https://assets5.lottiefiles.com/packages/lf20_ralbmkvl.json'),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Text(
                                'Belum ada transaksi',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: color1,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasData) {
                        final trans = snapshot.data!;

                        return ListBody(
                          children: trans.map(buildTrans).toList(),
                        );
                      } else if (snapshot.data == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Text("Please Wait");
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildTrans(Trans trans) => CardHistory(
        carImage: trans.imageUrl,
        carName: trans.carName,
        carDate: trans.datePick,
        numTrans: trans.idTrans,
        carTotPrice: trans.price,
        transStat: trans.status,
        tid: trans.tid,
        cid: trans.cid,
      );

  Stream<List<Trans>> readTrans() => FirebaseFirestore.instance
      .collection('trans')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where('status', isEqualTo: status)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Trans.fromJson(doc.data())).toList());
}

class Trans {
  String tid;
  String cid;
  String uid;
  String idTrans;
  String custName;
  String carName;
  String datePick;
  String dateReturn;
  int phone;
  String address;
  String price;
  String payment;
  String imageUrl;
  String status;

  Trans({
    required this.tid,
    required this.cid,
    required this.uid,
    required this.idTrans,
    required this.custName,
    required this.carName,
    required this.datePick,
    required this.dateReturn,
    required this.phone,
    required this.address,
    required this.price,
    required this.payment,
    required this.imageUrl,
    required this.status,
  });

  static Trans fromJson(Map<String, dynamic> json) => Trans(
      tid: json['tid'],
      cid: json['cid'],
      uid: json['uid'],
      idTrans: json['idTrans'],
      custName: json['custName'],
      carName: json['carName'],
      datePick: json['datePick'],
      dateReturn: json['dateReturn'],
      phone: json['phone'],
      address: json['address'],
      price: json['price'],
      payment: json['payment'],
      imageUrl: json['imageUrl'],
      status: json['status']);
}
