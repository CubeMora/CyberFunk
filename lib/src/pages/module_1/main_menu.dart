import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:security_info_project/src/models/drawer_sections.dart';
import 'package:security_info_project/src/models/video_class.dart';
import 'package:security_info_project/src/services/local_Data.dart';
import 'package:security_info_project/src/widgets/AppDrawer.dart';
import 'package:security_info_project/src/widgets/ButtonGeneralAction.dart';
import 'package:security_info_project/src/widgets/CyberFunkAppBar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  Future<List<VideoClass>> fetchClasses() async {
    await Future.delayed(const Duration(seconds: 1));
    return LocalData().getClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CyberFunkAppBar(),
        drawer: const AppDrawer(
          currentScreen: DrawerSections.home,
        ),
        body: FutureBuilder(
          future: fetchClasses(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.dotsTriangle(
                    color: Colors.black, size: 80.0),
              );
            } else if (snapshot.hasError) {
              return errorScreen(context);
            } else {
              final videoClasses = snapshot.data!;
              return Column(
                children: <Widget>[
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
                      itemCount: videoClasses.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 8.0,

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 11.0),
                          color: const Color.fromRGBO(
                              79, 77, 85, 1), //const Color(0xFF6A8E90),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              title: textNormal(18, videoClasses[index].title),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  textNormal(14.0,
                                      'Porcentaje completado ${videoClasses[index].percentage}%'),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: LinearProgressIndicator(
                                      value:
                                          videoClasses[index].percentage / 100,
                                      backgroundColor: Colors.grey[200],
                                      valueColor: const AlwaysStoppedAnimation<
                                              Color>(
                                          Color.fromARGB(255, 122, 182,
                                              179)), 
                                      minHeight: 7.0,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  videoClasses[index].percentage > 99
                                      ? SvgPicture.asset(
                                          'assets/svg/CompletedCircle.svg')
                                      : SvgPicture.asset(
                                          'assets/svg/UncompletedCircle.svg'),
                                  SvgPicture.asset('assets/svg/Badge.svg'),
                                ],
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/video',
                                    arguments: videoClasses[index]);
                              },
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(
                                duration: const Duration(milliseconds: 300),
                                delay: Duration(milliseconds: 100 * index))
                            .moveY(
                                begin: 10.0,
                                delay: Duration(milliseconds: 200 * index));
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }

  Column errorScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: Center(
              child: SvgPicture.asset(
            "assets/svg/screen_res/access_denied.svg",
            width: MediaQuery.of(context).size.width / 1.5,
          )),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          "¡Vaya!",
          style: GoogleFonts.majorMonoDisplay(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 40.0,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            "Parece que ha ocurrido un error al cargar los datos",
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 21.0,
              fontWeight: FontWeight.w300,
              height: 0,
            )),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.center,
            child: buttonGeneralAction("Recargar", () {
              setState(() {});
            }),
          ),
        )
      ],
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
