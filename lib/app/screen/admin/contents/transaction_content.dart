import 'dart:io';

import 'package:car_rental_ui/app/home/widgets/search_button.dart';
import 'package:car_rental_ui/app/screen/detail_cars/detail_cars.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'widgets/card_item.dart';

var size, height, width;

List<List<String>> itemList = [];

class TransAdminPage extends StatefulWidget {
  const TransAdminPage({Key? key}) : super(key: key);

  @override
  State<TransAdminPage> createState() => _TransAdminPageState();
}

class _TransAdminPageState extends State<TransAdminPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(
  //     vsync: this,
  //     length: myTabs.length,
  //   );
  // }

  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

  Stream<QuerySnapshot> streamQuery = FirebaseFirestore.instance
      .collection('trans')
      .where('status', isEqualTo: "Selesai")
      .snapshots();

  @override
  void initState() {
    super.initState();
    itemList = [
      <String>[
        "Nama Mobil (Nopol)",
        "Tanggal Pesan",
        "Jumlah Hari",
        "Jumlah Harga"
      ]
    ];
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              SearchButton(
                text1: "Transaction ",
                text2: "History",
                iconData: FontAwesomeIcons.fileArrowDown,
                onTapped: () {
                  generateCSV();
                },
              ),
              // SizedBox(
              //   height: 50,
              // ),
              Container(
                height: 60,
                child: TabBar(
                    indicatorColor: color1,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    unselectedLabelStyle:
                        GoogleFonts.montserrat(fontWeight: FontWeight.normal),
                    labelStyle:
                        GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                    tabs: [
                      Tab(
                        icon: Icon(FontAwesomeIcons.clockRotateLeft),
                        text: "Perlu Tindakan",
                      ),
                      Tab(
                        icon: Icon(FontAwesomeIcons.circleCheck),
                        text: "Selesai",
                      )
                    ]),
              ),
              Container(
                width: double.maxFinite,
                height: 500,
                child: TabBarView(children: [
                  //Perlu tindakan tabview
                  StreamBuilder<List<Trans>>(
                      stream: unconTrans(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                              'Something went wrong! ${snapshot.error}');
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
                  StreamBuilder<QuerySnapshot>(
                    stream: streamQuery,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot doc = snapshot.data!.docs[index];

                              itemList.add(<String>[
                                '${doc.get('carName')}(${doc.get('nopol')})',
                                doc.get('datePick'),
                                doc.get('dateReturn'),
                                doc.get('price'),
                              ]);
                              return ActionCard(
                                  carName: doc.get('carName'),
                                  carPlat: doc.get('nopol'),
                                  cusName: doc.get('custName'),
                                  cusPhone: int.parse(
                                      '${doc.get('phone').toString()}'),
                                  idTrans: doc.get('idTrans'),
                                  totPrice: doc.get('price'),
                                  tranStat: doc.get('status'),
                                  trasPay: doc.get('payment'),
                                  tid: doc.get('tid'),
                                  cid: doc.get('cid'),
                                  nopol: doc.get('nopol'));
                            });
                      }
                    },
                  )

                  //Selesai TabView
                  // StreamBuilder<List<Trans>>(
                  //     stream: conTrans(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasError) {
                  //         return Text(
                  //             'Something went wrong! ${snapshot.error}');
                  //       } else if (snapshot.hasData) {
                  //         final cars = snapshot.data!;
                  //         itemList.add(['${}']);
                  //         return ListView(
                  //           children: cars.map(showTrans).toList(),
                  //         );
                  //       } else {
                  //         return Center(
                  //           child: CircularProgressIndicator(),
                  //         );
                  //       }
                  //     }),
                ]),
              ),
            ],
          ),
        ),
      ));

  generateCSV() async {
    print('button is pressed');

    String csvData = ListToCsvConverter().convert(itemList);
    DateTime now = DateTime.now();
    String formatDate = DateFormat('HHmmss').format(now);

    Directory downloadDir = Directory('storage/emulated/0/Download');

    // final File file =
    //     await (File('${downloadDir.path}/item_export$formatDate.csv').create());

    // await file.writeAsString(csvData);
    print(itemList);
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
      );

  Stream<List<Trans>> unconTrans() => FirebaseFirestore.instance
      .collection('trans')
      .where('status', isEqualTo: "Diproses")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Trans.fromJson(doc.data())).toList());

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
                          color: _tranStat == "Diproses"
                              ? Colors.amber[100]
                              : color3,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      height: 30,
                      width: 70,
                      child: Center(
                          child: _tranStat == "Diproses"
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
                                    TextSettings(
                                        textcontent: "Konfirmasi",
                                        press: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: Text(
                                                        'Konfirmasi Transaksi'),
                                                    content:
                                                        Text('Anda Yakin ?'),
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
                                                                  'Selesai'
                                                            });

                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('Yes'))
                                                    ],
                                                  ));
                                        }),
                                    DividSettings(),
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
                                                press: () {},
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
