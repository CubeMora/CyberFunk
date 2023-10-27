import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CyberFunkAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CyberFunkAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: appTitleText(30.0),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 2.0,
      toolbarHeight: 70.0,
      actions: [
        Container(
          padding: const EdgeInsetsDirectional.only(end: 15.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey[400],
            child: const Icon(Icons.person_outline_sharp, color: Colors.black),
          ),
        )
      ],
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu),
        color: Colors.black,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Text appTitleText(double size) {
    return Text(
      'CyberFunk',
      style: GoogleFonts.majorMonoDisplay(
          textStyle: TextStyle(
        color: Colors.black,
        fontSize: size,
        fontWeight: FontWeight.w400,
        height: 0,
      )),
    );
  }
}
