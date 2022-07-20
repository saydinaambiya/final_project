import 'dart:io';
import 'package:car_rental_ui/app/home/views/login_screen.dart';
import 'package:car_rental_ui/app/home/widgets/search_button.dart';
import 'package:car_rental_ui/app/screen/admin/admin_home.dart';
import 'package:car_rental_ui/app/screen/admin/api/firebase_api.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/form_cars.dart';
import 'package:path/path.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({Key? key}) : super(key: key);

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  //Controller
  final carC = new TextEditingController();
  final yearC = new TextEditingController();
  final brandC = new TextEditingController();
  final fuelC = new TextEditingController();
  final seaterC = new TextEditingController();
  final nopolC = new TextEditingController();
  final gearC = new TextEditingController();
  final recomC = new TextEditingController();
  final statusC = new TextEditingController();
  final priceC = new TextEditingController();

  //var
  File? file;
  UploadTask? task;
  String? imageUrl;

  //select
  Future pickImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  //upload
  Future uploadImage() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'images/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlFile = await snapshot.ref.getDownloadURL();
    setState(() {
      imageUrl = urlFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchButton(
                text1: "New ",
                text2: "Car",
                iconData: FontAwesomeIcons.bars,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colorW,
                ),
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    FormCars(
                      cont: carC,
                      hint: "Avanza Veloz",
                      label: "Car Name",
                      iconData: Icon(FontAwesomeIcons.carRear),
                      keyboard: TextInputType.text,
                      inputAct: TextInputAction.next,
                    ),
                    FormCars(
                      cont: brandC,
                      hint: "Toyota",
                      label: "Brand",
                      iconData: Icon(FontAwesomeIcons.bandcamp),
                      keyboard: TextInputType.text,
                      inputAct: TextInputAction.next,
                    ),
                    FormCars(
                      cont: yearC,
                      hint: "2022",
                      label: "Year",
                      iconData: Icon(FontAwesomeIcons.calendarDays),
                      keyboard: TextInputType.number,
                      inputAct: TextInputAction.next,
                    ),
                    FormCars(
                      cont: fuelC,
                      hint: "Solar",
                      label: "Fuel",
                      iconData: Icon(FontAwesomeIcons.gasPump),
                      keyboard: TextInputType.text,
                      inputAct: TextInputAction.next,
                    ),
                    FormCars(
                      cont: seaterC,
                      hint: "7",
                      label: "Seater",
                      iconData: Icon(FontAwesomeIcons.couch),
                      keyboard: TextInputType.number,
                      inputAct: TextInputAction.next,
                    ),
                    FormCars(
                      cont: nopolC,
                      hint: "BL 123 AB",
                      label: "Nopol",
                      iconData: Icon(FontAwesomeIcons.closedCaptioning),
                      keyboard: TextInputType.text,
                      inputAct: TextInputAction.next,
                    ),
                    FormCars(
                      cont: gearC,
                      hint: "Manual",
                      label: "Transmition",
                      iconData: Icon(FontAwesomeIcons.gears),
                      keyboard: TextInputType.text,
                      inputAct: TextInputAction.next,
                    ),
                    FormCars(
                      cont: recomC,
                      hint: "Recommended",
                      label: "Recomendation",
                      iconData: Icon(FontAwesomeIcons.award),
                      keyboard: TextInputType.text,
                      inputAct: TextInputAction.next,
                    ),
                    FormCars(
                      cont: statusC,
                      hint: "Availabel",
                      label: "Status",
                      iconData: Icon(FontAwesomeIcons.certificate),
                      keyboard: TextInputType.text,
                      inputAct: TextInputAction.next,
                    ),
                    FormCars(
                      cont: priceC,
                      hint: "350.000",
                      label: "Price",
                      iconData: Icon(FontAwesomeIcons.rupiahSign),
                      keyboard: TextInputType.number,
                      inputAct: TextInputAction.done,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                      ),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.image),
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            child: file != null
                                ? Text(basename(file!.path))
                                : Text(
                                    "Upload Foto Mobil",
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
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await uploadImage();
                        final cars = Cars(
                            carName: carC.text,
                            brand: brandC.text,
                            year: int.parse(yearC.text),
                            fuel: fuelC.text,
                            seater: int.parse(seaterC.text),
                            nopol: nopolC.text,
                            transmition: gearC.text,
                            recomend: recomC.text,
                            status: statusC.text,
                            price: priceC.text,
                            imageUrl: '$imageUrl');
                        uploadCar(cars);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => AdminPage()));
                        showNotif(context, "Mobil berhasil ditambahkan");
                      },
                      height: 60,
                      minWidth: double.infinity,
                      color: color1,
                      textColor: colorW,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "Tambah Data",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future uploadCar(Cars cars) async {
  final docCar = FirebaseFirestore.instance.collection('cars').doc();
  cars.cid = docCar.id;

  final json = cars.toJson();
  await docCar.set(json);
}

class Cars {
  String cid;
  final String carName;
  final String brand;
  final int year;
  final String fuel;
  final int seater;
  final String nopol;
  final String transmition;
  final String recomend;
  final String status;
  final String price;
  String imageUrl;

  Cars({
    this.cid = '',
    required this.carName,
    required this.brand,
    required this.year,
    required this.fuel,
    required this.seater,
    required this.nopol,
    required this.transmition,
    required this.recomend,
    required this.status,
    required this.price,
    this.imageUrl = '',
  });

  Map<String, dynamic> toJson() => {
        'cid': cid,
        'carName': carName,
        'brand': brand,
        'year': year,
        'fuel': fuel,
        'seater': seater,
        'nopol': nopol,
        'transmition': transmition,
        'recomend': recomend,
        'status': status,
        'price': price,
        'imageUrl': imageUrl,
      };
}
