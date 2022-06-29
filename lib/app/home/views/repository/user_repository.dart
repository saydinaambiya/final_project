import 'package:car_rental_ui/app/home/models/user_model.dart';
import 'package:car_rental_ui/app/home/models/user_model_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserRepositoty {
  Future<UserModelView> getUser(String? email) async {
    var query = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (query.docs == null) {
      debugPrint('level ini adalah 1 ');

      return UserModelView();
    } else {
      debugPrint('level ini adalah 2 ');

      return UserModelView(
          address: query.docs[0]['address'] ?? '',
          email: query.docs[0]['email'] ?? '',
          fullName: query.docs[0]['fullName'] ?? '',
          level: query.docs[0]['level'] ?? '',
          phoneNumber: query.docs[0]['phoneNumber'] ?? '',
          uid: query.docs[0]['uid'] ?? '');
    }
  }
}
