import 'package:car_rental_ui/app/home/widgets/cars_item.dart';
import 'package:car_rental_ui/app/home/widgets/search_button.dart';
import 'package:car_rental_ui/app/screen/admin/contents/model/cars_model.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CarsRecom extends StatefulWidget {
  CarsRecom({Key? key}) : super(key: key);

  @override
  State<CarsRecom> createState() => _CarsRecomState();
}

class _CarsRecomState extends State<CarsRecom> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SearchButton(
            text1: "Recommended ",
            text2: "Cars",
            iconData: FontAwesomeIcons.list,
            onTapped: () {
              print("Iya udah ditekan");
            },
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                    child: StreamBuilder<List<Cars>>(
                        stream: readCars(),
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
                                children: [
                                  SizedBox(
                                    height: 100,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    height: 150,
                                    child: Lottie.network(
                                        'https://assets9.lottiefiles.com/packages/lf20_xzcx84wu.json'),
                                  ),
                                  Text(
                                    "Belum ada rekomendasi",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        color: color1,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            );
                          } else if (snapshot.hasData) {
                            final cars = snapshot.data!;
                            return ListBody(
                              children: cars.map(buildCard).toList(),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        })),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(Cars car) => CarItem(
        idC: car.cid,
        carName: car.carName,
        carYear: '${car.year}',
        imageLink: car.imageUrl,
        carPrice: car.price,
        carFuel: car.fuel,
        carSeater: '${car.seater}',
        carTransmition: car.transmition,
        carBrand: car.brand,
        carPlat: car.nopol,
      );

  Stream<List<Cars>> readCars() => FirebaseFirestore.instance
      .collection('cars')
      .where('status', isEqualTo: 'Available')
      .where('recomend', isEqualTo: 'Yes')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Cars.fromJson(doc.data())).toList());
}
