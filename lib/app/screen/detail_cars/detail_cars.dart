import 'dart:io';
import 'dart:math';

import 'package:car_rental_ui/app/home/views/home_screen.dart';
import 'package:car_rental_ui/app/home/views/login_screen.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:car_rental_ui/constants/text_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:car_rental_ui/app/screen/admin/api/firebase_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class DetailCars extends StatefulWidget {
  final String carId;
  final String imageUrl;
  final String name;
  final String year;
  final String price;
  final String seaters;
  final String transmition;
  final String fuel;
  final String nopol;

  DetailCars({
    Key? key,
    required this.carId,
    required this.imageUrl,
    required this.name,
    required this.year,
    required this.price,
    required this.seaters,
    required this.transmition,
    required this.fuel,
    required this.nopol,
  }) : super(key: key);

  @override
  _DetailCarsState createState() => _DetailCarsState(
        carId,
        imageUrl,
        name,
        year,
        price,
        seaters,
        transmition,
        fuel,
        nopol,
      );
}

class _DetailCarsState extends State<DetailCars> {
  //var uploadTransfer===========================
  File? file;
  UploadTask? task;
  String? transImage;
  //=============================================

  //select image
  Future pickImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
    });
  }

  //upload image
  Future uploadImage() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'transfer/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlFile = await snapshot.ref.getDownloadURL();
    setState(() {
      transImage = urlFile;
    });
  }

  //controller
  TextEditingController nameC = TextEditingController();
  TextEditingController datepickC = TextEditingController();
  TextEditingController datereturnC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController addressC = TextEditingController();

  String _carId;
  String _imageUrl;
  String _name;
  String _year;
  String _price;
  String _seaters;
  String _transmition;
  String _fuel;
  String _nopol;

  final FirebaseAuth auth = FirebaseAuth.instance;

  String? dropdownvalue;
  var items = [
    'Cash on Delivery',
    'Transfer Bank',
  ];

  bool isChecked = false;

  DateTime dateTime = DateTime.now();
  Random random = new Random();

  _selectDatePick() async {
    final DateTime? picked = await showDatePicker(
        context: this.context,
        initialDate: dateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));

    if (picked != null) {
      dateTime = picked;
      setState(() {
        datepickC.text = DateFormat("yyyy-MM-dd").format(dateTime);
        dateInput = datepickC.text;
      });
    }
  }

  _selectDateReturn() async {
    final DateTime? picked = await showDatePicker(
        context: this.context,
        initialDate: dateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));

    if (picked != null) {
      dateTime = picked;
      setState(() {
        datereturnC.text = DateFormat("yyyy-MM-dd").format(dateTime);
        dueDate = datereturnC.text;
      });
    }
  }

  String dateInput = DateTime.now().toString();
  String dueDate = DateTime.now().toString();

  _DetailCarsState(
    this._carId,
    this._imageUrl,
    this._name,
    this._year,
    this._price,
    this._seaters,
    this._transmition,
    this._fuel,
    this._nopol,
  );
  @override
  Widget build(BuildContext context) {
    DateTime createDateInput = DateTime.parse(dateInput);
    DateTime dueDateTime = DateTime.parse(dueDate);
    Duration duration = dueDateTime.difference(createDateInput);

    int harga = int.parse(_price);
    int hari = int.parse('${duration.inDays}');
    int totalharga = harga * hari;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                  color: colorW,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0.5,
                      blurRadius: 5,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 70,
                      right: 20,
                      left: 20,
                      bottom: 0,
                      child: Image.network(
                        _imageUrl,
                        width: 300,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.chevronLeft),
                                  color: Colors.black,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _name,
                                        style: TextConstants.carName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      // Text(
                                      //   _year,
                                      //   style: TextConstants.producedDate,
                                      //   overflow: TextOverflow.ellipsis,
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 15, 0, 10),
                child: Text(
                  "Specifications",
                  style: TextConstants.titleSection,
                ),
              ),
              Container(
                width: double.infinity,
                height: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                            color: color1,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 0.5,
                                blurRadius: 4,
                              )
                            ]),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/icons/ic_speedometer.png",
                                height: 30,
                                width: 30,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(text: _transmition),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                            color: color1,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 0.5,
                                blurRadius: 4,
                              )
                            ]),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/icons/ic_speedometer.png",
                                height: 30,
                                width: 30,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(text: _year),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 0.5,
                                blurRadius: 4,
                              )
                            ],
                            color: color1,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RotatedBox(
                                quarterTurns: 1,
                                child: Image.asset(
                                  "assets/icons/ic_cartopview.png",
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(text: '$_seaters Seater'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 0.5,
                                blurRadius: 4,
                              )
                            ],
                            color: color1,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RotatedBox(
                                quarterTurns: 1,
                                child: Image.asset(
                                  "assets/icons/ic_cartopview.png",
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(text: _fuel),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: colorW,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        spreadRadius: 0.5,
                      )
                    ]),
                child: Column(
                  children: [
                    inputData(FontAwesomeIcons.solidUser, "Nama Pelanggan",
                        TextInputType.name, nameC),
                    // inputData(
                    //     FontAwesomeIcons.calendarDays,
                    //     "Tanggal Pengambilan",
                    //     TextInputType.datetime,
                    //     datepickC),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.calendarDays,
                            color: color1,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              onTap: _selectDatePick,
                              // initialValue: "2022-07-20 12:00:00",
                              readOnly: true,
                              controller: datepickC,
                              textInputAction: TextInputAction.next,
                              // keyboardType: ,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Tanggal Pengambilan",
                                hintStyle: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.calendarDays,
                            color: color1,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              onTap: _selectDateReturn,
                              // initialValue: "2022-07-20 12:00:00",

                              readOnly: true,

                              controller: datereturnC,
                              textInputAction: TextInputAction.next,
                              // keyboardType: ,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Tanggal Pengembalian",
                                hintStyle: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // inputData(
                    //     FontAwesomeIcons.calendarDays,
                    //     "Tanggal Pengembalian",
                    //     TextInputType.datetime,
                    //     datereturnC),
                    inputData(FontAwesomeIcons.phone, "Nomor HP",
                        TextInputType.phone, phoneC),
                    inputData(FontAwesomeIcons.locationDot, "Alamat Pelanggan",
                        TextInputType.streetAddress, addressC),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                        Icon(
                          FontAwesomeIcons.wallet,
                          color: color1,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        DropdownButton(
                            hint: Text(
                              "Pilih Pembayaran",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.normal),
                            ),
                            value: dropdownvalue,
                            icon: Icon(Icons.keyboard_arrow_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            }),
                      ],
                    ),
                    dropdownvalue == 'Transfer Bank'
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, bottom: 10, top: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.buildingColumns,
                                      color: color1,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "BSI SYARIAH",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, bottom: 10, top: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.moneyCheckDollar,
                                      color: color1,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "7980966544",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      child: file != null
                                          ? Text(basename(file!.path),
                                              style: GoogleFonts.montserrat(
                                                  color: color1,
                                                  fontWeight: FontWeight.bold))
                                          : Text(
                                              "Upload Bukti Transfer",
                                              style: GoogleFonts.montserrat(
                                                  color: color1,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                      onTap: () => {
                                        pickImage(),
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    fillColor:
                                        MaterialStateProperty.all(Colors.blue),
                                    value: isChecked,
                                    shape: CircleBorder(),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 0,
                                  ),
                                  Text(
                                    "Menyetujui Syarat dan Ketentuan",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  )
                                ],
                              )
                            ],
                          )
                        : Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.all(Colors.blue),
                                value: isChecked,
                                shape: CircleBorder(),
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 0,
                              ),
                              Text(
                                "Menyetujui Syarat dan Ketentuan",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              )
                            ],
                          )
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
        bottomSheet: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 30),
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.montserrat(
                        fontSize: 17,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Total : ',
                      ),
                      TextSpan(
                        text: NumberFormat.currency(
                                locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                            .format(totalharga),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    if (isChecked == true) {
                      User? user = auth.currentUser;
                      final uid = user?.uid;
                      String id = DateFormat('MMdd').format(dateTime);
                      int randomInt = random.nextInt(1000);

                      await uploadImage();
                      final trans = Trans(
                          tid: '',
                          idTrans: 'CHR$id$randomInt',
                          cid: _carId,
                          uid: uid!,
                          carName: _name,
                          custName: nameC.text,
                          datePick: datepickC.text,
                          dateReturn: datereturnC.text,
                          phone: int.parse(phoneC.text),
                          address: addressC.text,
                          payment: dropdownvalue.toString(),
                          price: totalharga.toString(),
                          nopol: _nopol,
                          imageUrl: _imageUrl,
                          status: 'Diproses',
                          buktiTrans: '$transImage');
                      createTrans(trans);
                      final docCar = FirebaseFirestore.instance
                          .collection('cars')
                          .doc(_carId);
                      docCar.update({'status': 'Used'});

                      showNotif(context, "Mobil Berhasil di Pesan");
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    } else {
                      showNotif(
                          context, "Wajib Menyetujui Syarat dan Ketentuan");
                    }
                  },
                  child: Text(
                    "Book now",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: color1,
                    elevation: 0,
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget inputData(IconData icon, String text, TextInputType keyboard,
    TextEditingController dataC) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    child: Row(
      children: [
        Icon(
          icon,
          color: color1,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextFormField(
            controller: dataC,
            textInputAction: TextInputAction.next,
            keyboardType: keyboard,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: text,
              hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.normal),
            ),
          ),
        )
      ],
    ),
  );
}

Future createTrans(Trans trans) async {
  final docTrans = FirebaseFirestore.instance.collection('trans').doc();
  trans.tid = docTrans.id;

  final json = trans.toJson();
  await docTrans.set(json);
}

class Trans {
  String tid;
  String idTrans;
  String uid;
  String cid;
  String carName;
  String custName;
  String datePick;
  String dateReturn;
  int phone;
  String address;
  String payment;
  String price;
  String imageUrl;
  String status;
  String nopol;
  String buktiTrans;

  Trans({
    this.tid = '',
    this.idTrans = '',
    required this.uid,
    required this.cid,
    required this.carName,
    required this.custName,
    required this.datePick,
    required this.dateReturn,
    required this.phone,
    required this.address,
    required this.payment,
    required this.price,
    this.imageUrl = '',
    this.status = '',
    required this.nopol,
    this.buktiTrans = '',
  });

  Map<String, dynamic> toJson() => {
        'tid': tid,
        'idTrans': idTrans,
        'uid': uid,
        'cid': cid,
        'carName': carName,
        'custName': custName,
        'datePick': datePick,
        'dateReturn': dateReturn,
        'phone': phone,
        'address': address,
        'payment': payment,
        'price': price,
        'imageUrl': imageUrl,
        'status': status,
        'nopol': nopol,
        'buktiTrans': buktiTrans,
      };

  static Trans fromJson(Map<String, dynamic> json) => Trans(
        cid: json['cid'],
        uid: json['uid'],
        tid: json['tid'],
        carName: json['carName'],
        custName: json['custName'],
        address: json['address'],
        datePick: json['datePick'],
        dateReturn: json['dateReturn'],
        nopol: json['nopol'],
        payment: json['payment'],
        phone: json['phone'],
        price: json['price'],
        idTrans: json['idTrans'],
        imageUrl: json['imageUrl'],
        status: json['status'],
        buktiTrans: json['buktiTrans'],
      );
}
