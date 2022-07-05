import 'package:car_rental_ui/app/home/widgets/search_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransAdminPage extends StatefulWidget {
  const TransAdminPage({Key? key}) : super(key: key);

  @override
  State<TransAdminPage> createState() => _TransAdminPageState();
}

class _TransAdminPageState extends State<TransAdminPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SearchButton(
          text1: "Transaction ",
          text2: "History",
          iconData: FontAwesomeIcons.bars),
    ));
  }
}
