import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'card_history.dart';

class DropButton extends StatelessWidget {
  const DropButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(right: 10),
          width: 120,
          height: 30,
          child: TextButton(
            onPressed: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
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
                              "Semua Transaksi",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        BreakLine(),
                        TextModal(
                          text: "Semua Transaksi",
                          tap: () {},
                        ),
                        BreakLine(),
                        TextModal(
                          text: "Belum Dibayar",
                          tap: () {},
                        ),
                        BreakLine(),
                        TextModal(
                          text: "Dibatalkan",
                          tap: () {},
                        ),
                        BreakLine(),
                        TextModal(
                          text: "Selesai",
                          tap: () {},
                        ),
                        BreakLine(),
                      ],
                    );
                  });
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[300],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Semua Transaksi",
                  style:
                      GoogleFonts.montserrat(fontSize: 10, color: Colors.black),
                ),
                Icon(
                  FontAwesomeIcons.chevronDown,
                  size: 15,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
