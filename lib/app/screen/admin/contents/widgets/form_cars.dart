import 'package:flutter/material.dart';

class FormCars extends StatelessWidget {
  const FormCars({
    Key? key,
    required this.cont,
    required this.hint,
    required this.label,
    required this.iconData,
    required this.keyboard,
    required this.inputAct,
  }) : super(key: key);

  final TextEditingController cont;
  final String hint;
  final String label;
  final Icon iconData;
  final TextInputType keyboard;
  final TextInputAction inputAct;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: cont,
      keyboardType: keyboard,
      textInputAction: inputAct,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        icon: iconData,
        enabledBorder: InputBorder.none,
      ),
    );
  }
}
