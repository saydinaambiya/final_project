import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'card_history.dart';

Future<dynamic> settingPopup(BuildContext context) => showModalBottomSheet(
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
                "Account Settings",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          BreakLine(),
          TextModal(text: "Edit Profile"),
          BreakLine(),
          TextModal(text: "Logout"),
          BreakLine(),
        ],
      );
    });
