import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextConstants {
  static TextStyle titleSection = GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static TextStyle carName = GoogleFonts.montserrat(
      fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle producedDate = GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle darkCarName = GoogleFonts.montserrat(
      fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black87);
  static TextStyle darkProducedDate = GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black38,
  );
}
