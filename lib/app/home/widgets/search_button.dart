import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    required this.text1,
    required this.text2,
    required this.iconData,
    Key? key,
  }) : super(key: key);

  final String text1;
  final String text2;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  color: Colors.black87,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: text1,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: text2),
                ],
              ),
            ),
            IconButton(
              alignment: Alignment.centerRight,
              icon: Icon(iconData),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
