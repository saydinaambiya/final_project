import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'search_button.dart';
import 'brand_list.dart';
import 'package:car_rental_ui/constants/text_constants.dart';
import 'cars_item.dart';
import 'package:car_rental_ui/app/screen/admin/contents/model/cars_model.dart';

// var brand = [
//   'Toyota',
//   'Mitsubishi',
// ];

// String brand = 'Mitshubishi';

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SearchButton(
              text1: "Rental",
              text2: " App",
              iconData: FontAwesomeIcons.magnifyingGlass,
              onTapped: () {
                print("Iya udah ditekan");
              },
            ),
            BrandList(),
            Container(
              // margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Available Cars",
                          style: TextConstants.titleSection,
                        ),
                        IconButton(
                          onPressed: () {
                            print("filter cars");
                          },
                          icon: Icon(FontAwesomeIcons.list),
                        )
                      ],
                    ),
                  ),
                  StreamBuilder<List<Cars>>(
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
                                  height: 70,
                                ),
                                SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Lottie.network(
                                      'https://assets9.lottiefiles.com/packages/lf20_xzcx84wu.json'),
                                ),
                                Text(
                                  "Mobil tidak tersedia",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      color: color1),
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
                      })
                ],
              ),
            ),
          ],
        ),
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
      // .where('brand', isEqualTo: brand)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Cars.fromJson(doc.data())).toList());

  // Stream<List<Cars>> allCars() => FirebaseFirestore.instance
  //     .collection('cars')
  //     .where('status', isEqualTo: 'Available')
  //     // .where('brand', isEqualTo: '')
  //     .snapshots()
  //     .map((snapshot) =>
  //         snapshot.docs.map((doc) => Cars.fromJson(doc.data())).toList());
}
