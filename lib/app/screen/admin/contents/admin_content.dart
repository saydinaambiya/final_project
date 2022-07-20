import 'package:car_rental_ui/app/home/widgets/search_button.dart';
import 'model/cars_model.dart';
import 'package:car_rental_ui/app/screen/admin/contents/widgets/trans_card.dart';
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
              iconData: FontAwesomeIcons.list),
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
              })
        ]),
      ),
    ));
  }

  // Widget buildCar(Cars car) => ListTile(
  //       leading: CircleAvatar(child: Text('${car.year}')),
  //       title: Text(car.carName),
  //       subtitle: Text(car.transmition),
  //     );

  Widget buildCar(Cars car) => TransCard(
      imageURl: car.imageUrl,
      carName: car.carName,
      carYear: '${car.year}',
      price: car.price);

  Stream<List<Cars>> readCars() => FirebaseFirestore.instance
      .collection('cars')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Cars.fromJson(doc.data())).toList());
}
