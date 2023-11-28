import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FirstScreen extends StatefulWidget {
  FirstScreen({super.key});


  

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
@override
void initState() {
  super.initState();
  
}

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 50.0),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.53,
              color: const Color(0xFF3C3C3C),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appTitleText(40.0),
                  const SizedBox(height: 100.0),
                  SizedBox(
                    width: 278,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          textNormal(20, 'Ciberseguridad simplificada: '),
                          textNormal(20, 'acceso a cursos en cualquier momento, en cualquier lugar')
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              )),
            ),
            Text('Escribe tu nombre para comenzar',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                ))),
            _textUserNameInput(myController),
            buttonGeneralAction("Continuar", () => navigateToNextScreen(context)),
          ],
        ),
      ),
    );
  }

  TextSpan textNormal(double size, String text) {
    return TextSpan(
      text: text,
      style: GoogleFonts.inter(
          textStyle: TextStyle(
        color: const Color(0xFFF4F4F4),
        fontSize: size,
        fontWeight: FontWeight.w500,
        height: 0,
      )),
    );
  }

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

  Text appTitleText(double size) {
    return Text(
      'CyberFunk',
      style: GoogleFonts.majorMonoDisplay(
          textStyle: TextStyle(
        color: const Color(0xFFF4F4F4),
        fontSize: size,
        fontWeight: FontWeight.w400,
        height: 0,
      )),
    );
  }

Widget _textUserNameInput(TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 90.0, vertical: 65.0),
    child: TextField(
      controller: controller,
      decoration: const InputDecoration(
          hintText: "Nombre completo",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    ),
  );
}

void navigateToNextScreen(BuildContext context) async {
  String textToSend = myController.text;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (textToSend != "") {
    prefs.setString('username', textToSend);
  }else{

    prefs.setString('username', "Guest");
  }
  // ignore: use_build_context_synchronously
  Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
}
}

