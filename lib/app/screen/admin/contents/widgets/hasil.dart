import 'package:car_rental_ui/app/home/models/upload_model.dart';
import 'package:car_rental_ui/app/home/views/login_screen.dart';
import 'package:car_rental_ui/app/home/widgets/search_button.dart';
import 'package:car_rental_ui/app/screen/admin/contents/model/cars_model.dart';
import 'package:car_rental_ui/app/screen/admin/contents/widgets/card_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HasilPage extends StatelessWidget {
  UploadModel uploadModel;
  HasilPage(this.uploadModel);

  @override
  Widget build(BuildContext context) {
    ScrollController? controller;
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: ListView.builder(
                controller: controller,
                shrinkWrap: true,
                itemCount: uploadModel.data!.length,
                itemBuilder: (context, index) {
                  return StreamBuilder<List<Cars>>(
                      stream: readCars(uploadModel.data![index].toString()),
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
                          return Text('data kosong');
                          // return Center(
                          //   child: Column(
                          //     children: [
                          //       Text(
                          //         "Mobil Rekomendasi tidak Tersedia",
                          //         style: GoogleFonts.montserrat(),
                          //       ),
                          //     ],
                          //   ),
                          // );
                        } else if (snapshot.hasData) {
                          final cars = snapshot.data!;
                          return ListBody(
                            children: cars.map(buildCar).toList(),
                            // children: uploadModel.data!.map((e) => buildCar(e)).toList(),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      });
                }),
          ),
          SearchButton(
            text1: 'CV. Cahaya',
            text2: ' Rental',
            iconData: FontAwesomeIcons.list,
            onTapped: () {
              showNotif(context, "Coming Soon");
            },
          ),
        ],
      )),
    );
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

  Stream<List<Cars>> readCars(String equalAPi) => FirebaseFirestore.instance
      .collection('cars')
      .where('nopol', isEqualTo: equalAPi)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Cars.fromJson(doc.data())).toList());
}
