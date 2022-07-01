import 'package:car_rental_ui/app/home/models/user_model_view.dart';
import 'package:car_rental_ui/app/home/views/home_screen.dart';
import 'package:car_rental_ui/app/home/views/login_screen.dart';
import 'package:car_rental_ui/app/home/views/repository/auth_repository.dart';
import 'package:car_rental_ui/app/home/views/repository/user_repository.dart';
import 'package:car_rental_ui/app/screen/admin/admin_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  @override
  Widget build(BuildContext context) {
    AutRepository _auth = AutRepository();
    return StreamBuilder<User?>(
        stream: _auth.dataAuth,
        builder: (context, user) {
          if (user.data == null) {
            return LoginPage();
          } else {
            return StreamBuilder<UserModelView>(
                stream: UserRepositoty().getUser(user.data!.email).asStream(),
                builder: (context, snapshot) {
                  return snapshot.data?.level == 'admin'
                      ? AdminPage()
                      : HomeScreen();
                });
          }
        });
  }
}

//WelcomePage()