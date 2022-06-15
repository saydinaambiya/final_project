import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'card_history.dart';

Future<dynamic> modalPopup(BuildContext context) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(FontAwesomeIcons.xmark),
                ),
                Text(
                  "Lainnya",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            BreakLine(),
            TextModal(text: "Lihat Invoice"),
            BreakLine(),
            TextModal(text: "Batalkan Pesanan"),
            BreakLine(),
            TextModal(text: "Pesan Lagi"),
            BreakLine(),
            TextModal(text: "Hubungi"),
            BreakLine(),
          ],
        );
      });
}
