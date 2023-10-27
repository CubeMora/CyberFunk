import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textNormalDark(double size, String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
          textStyle: TextStyle(
        color: Colors.black,
        fontSize: size,
        fontWeight: FontWeight.w500,
        height: 0,
      )),
    );
  }