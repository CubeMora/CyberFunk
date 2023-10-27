import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buttonGeneralAction(String text, void Function() action) {
    return ElevatedButton(
      
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size(150.0, 50.0)),
          backgroundColor: MaterialStateColor.resolveWith(
              (states) => const Color(0xFF3C3C3C))),
      onPressed: action,
      child: Text(text,
          style: GoogleFonts.inter(
              textStyle: const TextStyle(
            color: Color(0xFFF4F4F4),
            fontSize: 19,
            fontWeight: FontWeight.w500,
            height: 0,
          ))),
    );
  }
