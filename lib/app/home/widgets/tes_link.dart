import 'package:flutter/material.dart';

class TestLink extends StatelessWidget {
  String image2;
  String datamobil;
  TestLink({Key? key, required this.image2, required this.datamobil})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Image.network(image2), Text(datamobil)],
      ),
    );
  }
}
