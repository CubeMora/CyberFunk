import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:security_info_project/src/pages/main_menu.dart';
import 'package:security_info_project/src/widgets/ButtonGeneralAction.dart';
import 'package:security_info_project/src/widgets/CyberFunkAppBar.dart';
import 'package:security_info_project/src/widgets/textNormalDark.dart';

class BadgeScreen extends StatelessWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CyberFunkAppBar(),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset('assets/svg/badgeScreen.svg'),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
            child: Text(
              "¡Felicidades, haz completado la lección!",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                
                  textStyle: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
                height: 0,
                

              )),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          buttonGeneralAction("Terminar", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainMenu(
                    // textPassed: textToSend,
                    ),
              ),
            );
          })
        ]),
      ),
    );
  }
}
