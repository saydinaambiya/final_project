import 'dart:io';

import 'package:car_rental_ui/app/home/views/login_screen.dart';
import 'package:car_rental_ui/app/home/widgets/search_button.dart';
import 'package:car_rental_ui/app/screen/admin/api/upload_api.dart';
import 'package:car_rental_ui/app/screen/admin/contents/process_apriori.dart';
import 'package:car_rental_ui/app/screen/detail_cars/detail_cars.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/card_item.dart';

var size, height, width;

List<List<String>> itemList = [];

class TransAdminPage extends StatefulWidget {
  const TransAdminPage({Key? key}) : super(key: key);

  @override
  State<TransAdminPage> createState() => _TransAdminPageState();
}

class _TransAdminPageState extends State<TransAdminPage> {
  //Selesai Stream v.2
  Stream<QuerySnapshot> streamQuery = FirebaseFirestore.instance
      .collection('trans')
      .where('status', isEqualTo: "Selesai")
      .snapshots();

  @override
  void initState() {
    super.initState();
    itemList = [
      <String>["id", "item"]
    ];
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              SearchButton(
                text1: "Transaction ",
                text2: "History",
                iconData: FontAwesomeIcons.circleArrowDown,
                onTapped: () {
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
                            TextSettings(
                                textcontent: "Export Data",
                                press: () {
                                  generateCSV();
                                  Navigator.pop(context);
                                }),
                            DividSettings(),
                            TextSettings(
                              press: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProsesApriori()));
                              },
                              textcontent: "Generate Data Rekomendasi",
                            ),
                            DividSettings(),
                          ],
                        );
                      });
                },
              ),
              //Tab Container
              Container(
                height: 60,
                child: TabBar(
                    indicatorColor: color1,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    unselectedLabelStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.normal,
                      fontSize: 11,
                    ),
                    labelStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                    tabs: [
                      //Diproses tab
                      Tab(
                        icon: Icon(FontAwesomeIcons.clockRotateLeft),
                        // text: "Diproses",
                      ),
                      //Dibatalkan tab
                      Tab(
                        icon: Icon(FontAwesomeIcons.circleXmark),
                        // text: "Dibatalkan",
                      ),
                      //Dikonfimasi tab
                      Tab(
                        icon: Icon(FontAwesomeIcons.circleCheck),
                        // text: "Dikonfirmasi",
                      ),
                      //Selesai tab
                      Tab(
                        icon: Icon(FontAwesomeIcons.clipboard),
                        // text: "Selesai",
                      )
                    ]),
              ),
              //Tabview Container
              Container(
                width: double.maxFinite,
                height: 500,
                child: TabBarView(children: [
                  //Diproses tabview
                  StreamBuilder<List<Trans>>(
                      stream: unconTrans(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                              'Something went wrong! ${snapshot.error}');
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.data!.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Lottie.network(
                                      'https://assets5.lottiefiles.com/packages/lf20_ralbmkvl.json'),
                                ),
                                Text(
                                  'Belum ada transaksi',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: color1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasData) {
                          final cars = snapshot.data!;

                          return ListView(
                            children: cars.map(showTrans).toList(),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                  //Dibatalkan tabview
                  StreamBuilder<List<Trans>>(
                      stream: cancTrans(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                              'Something went wrong! ${snapshot.error}');
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.data!.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Lottie.network(
                                      'https://assets5.lottiefiles.com/packages/lf20_ralbmkvl.json'),
                                ),
                                Text(
                                  'Belum ada transaksi',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: color1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasData) {
                          final cars = snapshot.data!;

                          return ListView(
                            children: cars.map(showTrans).toList(),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                  //Dikonfirmasi tabview
                  StreamBuilder<List<Trans>>(
                      stream: accTrans(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                              'Something went wrong! ${snapshot.error}');
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.data!.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Lottie.network(
                                      'https://assets5.lottiefiles.com/packages/lf20_ralbmkvl.json'),
                                ),
                                Text(
                                  'Belum ada transaksi',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: color1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasData) {
                          final cars = snapshot.data!;

                          return ListView(
                            children: cars.map(showTrans).toList(),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                  //Selesai Tabview v.2
                  StreamBuilder<QuerySnapshot>(
                    stream: streamQuery,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: Lottie.network(
                                    'https://assets5.lottiefiles.com/packages/lf20_ralbmkvl.json'),
                              ),
                              Text(
                                'Belum ada transaksi',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: color1,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot doc = snapshot.data!.docs[index];

                              itemList.add(<String>[
                                doc.get('cid'),
                                doc.get('nopol'),
                              ]);
                              return ActionCard(
                                carName: doc.get('carName'),
                                carPlat: doc.get('nopol'),
                                cusName: doc.get('custName'),
                                cusPhone:
                                    int.parse('${doc.get('phone').toString()}'),
                                idTrans: doc.get('idTrans'),
                                totPrice: doc.get('price'),
                                tranStat: doc.get('status'),
                                trasPay: doc.get('payment'),
                                tid: doc.get('tid'),
                                cid: doc.get('cid'),
                                nopol: doc.get('nopol'),
                                buktiTrans: doc.get('buktiTrans'),
                              );
                            });
                      }
                    },
                  )
                ]),
              ),
            ],
          ),
        ),
      ));

  //Function CSV
  generateCSV() async {
    print('button is pressed');

    String csvData = ListToCsvConverter().convert(itemList);
    DateTime now = DateTime.now();
    String formatDate = DateFormat('HHmmss').format(now);

    Directory downloadDir = Directory('storage/emulated/0/Download');

    final File file =
        await (File('${downloadDir.path}/item_export$formatDate.csv').create());

    await file.writeAsString(csvData);
    showNotif(context, "$file Downloaded");
  }

  Widget showTrans(Trans trans) => ActionCard(
        carName: trans.carName,
        carPlat: trans.nopol,
        cusName: trans.custName,
        cusPhone: trans.phone,
        idTrans: trans.idTrans,
        totPrice: trans.price,
        tranStat: trans.status,
        trasPay: trans.payment,
        tid: trans.tid,
        cid: trans.cid,
        nopol: trans.nopol,
        buktiTrans: trans.buktiTrans,
      );

  //Proses Stream
  Stream<List<Trans>> unconTrans() => FirebaseFirestore.instance
      .collection('trans')
      .where('status', isEqualTo: "Diproses")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Trans.fromJson(doc.data())).toList());

  //Dibatalkan Stream
  Stream<List<Trans>> cancTrans() => FirebaseFirestore.instance
      .collection('trans')
      .where('status', isEqualTo: "Dibatalkan")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Trans.fromJson(doc.data())).toList());
  //Dikonfirmasi Stream
  Stream<List<Trans>> accTrans() => FirebaseFirestore.instance
      .collection('trans')
      .where('status', isEqualTo: "Dikonfirmasi")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Trans.fromJson(doc.data())).toList());
  //Selesai Stream
  Stream<List<Trans>> conTrans() => FirebaseFirestore.instance
      .collection('trans')
      .where('status', isEqualTo: "Selesai")
      // .where('status', isEqualTo: "Dibatalkan")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Trans.fromJson(doc.data())).toList());
}

class ActionCard extends StatefulWidget {
  const ActionCard({
    required this.carName,
    required this.carPlat,
    required this.cusName,
    required this.cusPhone,
    required this.idTrans,
    required this.totPrice,
    required this.tranStat,
    required this.trasPay,
    required this.tid,
    required this.cid,
    required this.nopol,
    required this.buktiTrans,
    Key? key,
  }) : super(key: key);

  final String carName;
  final String carPlat;
  final String tranStat;
  final String cusName;
  final int cusPhone;
  final String idTrans;
  final String totPrice;
  final String trasPay;
  final String tid;
  final String cid;
  final String nopol;
  final String buktiTrans;

  @override
  State<ActionCard> createState() => _ActionCardState(
        carName,
        carPlat,
        tranStat,
        cusName,
        cusPhone,
        idTrans,
        totPrice,
        trasPay,
        tid,
        cid,
        nopol,
        buktiTrans,
      );
}

class _ActionCardState extends State<ActionCard> {
  final String _carName;
  final String _carPlat;
  final String _tranStat;
  final String _cusName;
  final int _cusPhone;
  final String _idTrans;
  final String _totPrice;
  final String _trasPay;
  final String _tid;
  final String _cid;
  final String _nopol;
  final String buktiTrans;

  _ActionCardState(
    this._carName,
    this._carPlat,
    this._tranStat,
    this._cusName,
    this._cusPhone,
    this._idTrans,
    this._totPrice,
    this._trasPay,
    this._tid,
    this._cid,
    this._nopol,
    this.buktiTrans,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
          color: colorW,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0.3,
              blurRadius: 2,
            )
          ]),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _carName,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      _carPlat,
                      style: GoogleFonts.montserrat(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: _tranStat == "Diproses" ||
                                  _tranStat == "Dibatalkan"
                              ? Colors.amber[100]
                              : color3,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      height: 30,
                      width: 100,
                      child: Center(
                          child: _tranStat == "Diproses" ||
                                  _tranStat == "Dibatalkan"
                              ? Text(
                                  widget.tranStat,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  _tranStat,
                                  style: GoogleFonts.montserrat(
                                      color: color1,
                                      fontWeight: FontWeight.bold),
                                )),
                    ),
                    IconButton(
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
                                    //Konfirmasi Transaksi
                                    _tranStat == "Diproses"
                                        ? TextSettings(
                                            textcontent: "Konfirmasi",
                                            press: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        title: Text(
                                                            'Konfirmasi Transaksi'),
                                                        content: Text(
                                                            'Anda Yakin ?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {},
                                                            child: Text('No'),
                                                          ),
                                                          TextButton(
                                                              onPressed: () {
                                                                final docTrans = FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'trans')
                                                                    .doc(widget
                                                                        .tid);
                                                                docTrans
                                                                    .update({
                                                                  'status':
                                                                      'Selesai'
                                                                });

                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child:
                                                                  Text('Yes'))
                                                        ],
                                                      ));
                                            })
                                        : SizedBox(),
                                    // DividSettings(),
                                    //Batalkan Transaksi
                                    TextSettings(
                                      press: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text(
                                                      'Batalkan Transaksi'),
                                                  content: Text('Anda Yakin ?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {},
                                                      child: Text('No'),
                                                    ),
                                                    TextButton(
                                                        onPressed: () {
                                                          final docTrans =
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'trans')
                                                                  .doc(widget
                                                                      .tid);
                                                          docTrans.update({
                                                            'status':
                                                                'Dibatalkan'
                                                          });
                                                          final docCar =
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'cars')
                                                                  .doc(widget
                                                                      .cid);
                                                          docCar.update({
                                                            'status':
                                                                'Available'
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Yes'))
                                                  ],
                                                ));
                                      },
                                      textcontent: "Batalkan",
                                    ),
                                    DividSettings(),
                                    widget.trasPay == 'Transfer Bank'
                                        ? Column(
                                            children: [
                                              TextSettings(
                                                press: () async {
                                                  final Uri url =
                                                      Uri.parse('$buktiTrans');

                                                  if (!await launchUrl(url,
                                                      mode: LaunchMode
                                                          .inAppWebView)) {
                                                    throw 'Could not launch $url';
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                textcontent:
                                                    "Lihat Bukti Transfer",
                                              ),
                                              DividSettings()
                                            ],
                                          )
                                        : SizedBox(
                                            height: 10,
                                          )
                                  ],
                                );
                              });
                        },
                        icon: Icon(FontAwesomeIcons.ellipsisVertical))
                  ],
                ),
              ],
            ),
          ),
          Divider(
            indent: 10,
            endIndent: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.cusName,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      '0${widget.cusPhone}',
                      style: GoogleFonts.montserrat(),
                    ),
                    Text(
                      widget.idTrans,
                      style: GoogleFonts.montserrat(),
                    ),
                    Text(
                      widget.trasPay,
                      style: GoogleFonts.montserrat(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Total Harga :",
                        style: GoogleFonts.montserrat(),
                      ),
                      Text(
                        NumberFormat.currency(
                                locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                            .format(int.parse(widget.totPrice)),
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
