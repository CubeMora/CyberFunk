import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:security_info_project/src/pages/video_screen.dart';
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
  late SharedPreferences sharedPrefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
    });
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
  Widget build(BuildContext context) {
    final username = sharedPrefs.getString("username");
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: CyberFunkAppBar(),
          drawer: Drawer(
            child: ListView(
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: const Text('item 1'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('item 2'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: textNormalDark(20.0, "Bienvenido $username"),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Modulo 1'),
                subtitle: Text('Educacion en ciberseguridad'),
                trailing: Icon(Icons.check_circle_outline_outlined),
              ),
              Divider(
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
                      margin: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 11.0),
                      color: Color(0xFF6A8E90),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          //leading: Icon(Icons.check_circle_outline_outlined),
                          title: textNormal(18, '${items[index]}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10.0,
                              ),
                              textNormal(14.0,
                                  'Porcentaje completado ${percentages[index]}%'),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: LinearProgressIndicator(
                                  value: percentages[index] / 100,
                                  backgroundColor: Colors.grey[200],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color.fromARGB(255, 21, 235, 117)),
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
                                builder: (context) => VideoCourseScreen(
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
          )),
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
