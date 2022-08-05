import 'package:car_rental_ui/app/home/views/login_screen.dart';
import 'package:car_rental_ui/app/home/widgets/search_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'model/cars_model.dart';
import 'package:car_rental_ui/app/screen/admin/contents/widgets/card_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SearchButton(
            text1: 'CV. Cahaya',
            text2: ' Rental',
            iconData: FontAwesomeIcons.list,
            onTapped: () {
              showNotif(context, "Coming Soon");
            },
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: Row(
              children: [
                Text(
                  "Mobil Rekomendasi",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          //StreamRecommend
          StreamBuilder<List<Cars>>(
              stream: recomCars(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong! ${snapshot.error}');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          "Mobil Rekomendasi tidak Tersedia",
                          style: GoogleFonts.montserrat(),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasData) {
                  final cars = snapshot.data!;
                  return ListBody(
                    children: cars.map(buildCar).toList(),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              bottom: 20,
              top: 20,
            ),
            child: Row(
              children: [
                Text(
                  "Mobil Tersedia",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          //StreamAvailable
          StreamBuilder<List<Cars>>(
              stream: readCars(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong! ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final cars = snapshot.data!;

                  return ListBody(
                    children: cars.map(buildCar).toList(),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20, top: 20),
            child: Row(
              children: [
                Text(
                  "Mobil Sedang Digunakan",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          //StreamUsed
          StreamBuilder<List<Cars>>(
              stream: usedCars(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong! ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final cars = snapshot.data!;

                  return ListBody(
                    children: cars.map(buildCar).toList(),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ]),
      ),
    ));
  }

  // Widget buildCar(Cars car) => ListTile(
  //       leading: CircleAvatar(child: Text('${car.year}')),
  //       title: Text(car.carName),
  //       subtitle: Text(car.transmition),
  //     );

  Widget buildCar(Cars car) => CardItem(
        cid: car.cid,
        imageURl: car.imageUrl,
        carName: car.carName,
        carYear: '${car.year}',
        price: car.price,
        carBrand: car.brand,
        fuel: car.fuel,
        nopol: car.nopol,
        seater: '${car.seater}',
        transmition: car.transmition,
        status: car.status,
        recomend: car.recomend,
      );

  Stream<List<Cars>> readCars() => FirebaseFirestore.instance
      .collection('cars')
      .where('status', isEqualTo: 'Available')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Cars.fromJson(doc.data())).toList());

  Stream<List<Cars>> usedCars() => FirebaseFirestore.instance
      .collection('cars')
      .where('status', isEqualTo: 'Used')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Cars.fromJson(doc.data())).toList());

  Stream<List<Cars>> recomCars() => FirebaseFirestore.instance
      .collection('cars')
      .where('status', isEqualTo: 'Available')
      .where('recomend', isEqualTo: 'Yes')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Cars.fromJson(doc.data())).toList());
}
