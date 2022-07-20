import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Cars fromJson(Map<String, dynamic> json) => Cars(
      carName: json['carName'],
      brand: json['brand'],
      year: json['year'],
      fuel: json['fuel'],
      seater: json['seater'],
      nopol: json['nopol'],
      transmition: json['transmition'],
      recomend: json['recomend'],
      status: json['status'],
      imageUrl: json['imageUrl'],
      price: json['price']);
}
