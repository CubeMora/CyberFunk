import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:security_info_project/src/pages/video_screen.dart';
import 'package:security_info_project/src/settings/settings_controller.dart';
import 'package:security_info_project/src/settings/settings_service.dart';
import 'package:security_info_project/src/widgets/AppDrawer.dart';
import 'package:security_info_project/src/widgets/CyberFunkAppBar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:security_info_project/src/widgets/textNormalDark.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  Future chargePrefs() async {
    return await SharedPreferences.getInstance();
  }

  List<String> items = [
    'Seguridad en línea',
    'Escenarios de phishing',
    'Fraudes en línea',
    'Protección de identidad personal',
    'Importancia de las contraseñas fuertes',
    'Actualizaciones periódicas'
  ];
  List<int> percentages = [50, 75, 100, 25, 10, 100];
  List<bool> completed = [false, false, true, false, true, true];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     final SettingsService _settingsService = SettingsService();
    final SettingsController controller = SettingsController(_settingsService);
    Future.microtask(() => controller.updateThemeMode(ThemeMode.light));
   
  }

  @override
  Widget build(BuildContext context) {
    // final username = sharedPrefs.getString("username");
    return FutureBuilder(
      future: chargePrefs(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          final SharedPreferences prefs = snapshot.data!;

          final username = prefs.getString('username');

          return Scaffold(
              appBar: const CyberFunkAppBar(),
              drawer: const AppDrawer(),
              body: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: textNormalDark(20.0, "Bienvenido $username"),
                  ),
                  const ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Modulo 1'),
                    subtitle: Text('Educacion en ciberseguridad'),
                    trailing: Icon(Icons.check_circle_outline_outlined),
                  ),
                  const Divider(
                    indent: 30.0,
                    endIndent: 30.0,
                    thickness: 1.5,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 11.0),
                          color: const Color(0xFF6A8E90),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              //leading: Icon(Icons.check_circle_outline_outlined),
                              title: textNormal(18, items[index]),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  textNormal(14.0,
                                      'Porcentaje completado ${percentages[index]}%'),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: LinearProgressIndicator(
                                      value: percentages[index] / 100,
                                      backgroundColor: Colors.grey[200],
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Color.fromARGB(
                                                  255, 21, 235, 117)),
                                      minHeight: 7.0,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  percentages[index] > 99
                                      ? SvgPicture.asset(
                                          'assets/svg/CompletedCircle.svg')
                                      : SvgPicture.asset(
                                          'assets/svg/UncompletedCircle.svg'),
                                  SvgPicture.asset('assets/svg/Badge.svg'),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const VideoCourseScreen(
                                            // textPassed: textToSend,
                                            ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ));
        } else {
          // Mientras el Future aún no está completo, puedes mostrar un indicador de carga.
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget textNormal(double size, String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
          textStyle: TextStyle(
        color: const Color(0xFFF4F4F4),
        fontSize: size,
        fontWeight: FontWeight.w500,
        height: 0,
      )),
    );
  }
}
