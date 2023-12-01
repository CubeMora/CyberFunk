// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:security_info_project/src/models/drawer_sections.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    this.currentScreen,
  });

  final DrawerSections? currentScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(52, 51, 58, 1),
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(20.0))),
            child: Text('Módulos',
                style: GoogleFonts.majorMonoDisplay(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: Colors.white),
                )),
          ),
          ListTile(
            title: const Text('Módulo 1'),
            subtitle: const Text('Educación en ciberseguridad'),
            leading: const Icon(Icons.school),
            selected: currentScreen == DrawerSections.home,
            selectedTileColor: const Color.fromARGB(255, 67, 66, 71),
            selectedColor: Colors.white,
            onTap: () {
              Navigator.pop(context);
              if (currentScreen != DrawerSections.home) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/main', (_) => false);
              }
            },
          ),
          ListTile(
            title: const Text('Módulo 2'),
            subtitle: const Text('Blogs sobre ciberseguridad'),
            leading: const Icon(Icons.newspaper_rounded),
            selected: currentScreen == DrawerSections.blog,
            selectedTileColor: const Color.fromARGB(255, 67, 66, 71),
            selectedColor: Colors.white,
            onTap: () {
              Navigator.pop(context);
              if (currentScreen != DrawerSections.blog) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/blog', (_) => false);
              }
            },
          ),
          ListTile(
            title: const Text('Módulo 3'),
            subtitle: const Text('Actos de prevención y respuesta'),
            leading: const Icon(Icons.shield_outlined),
            selected: currentScreen == DrawerSections.actions,
            selectedTileColor: const Color.fromARGB(255, 67, 66, 71),
            selectedColor: Colors.white,
            onTap: () {
              Navigator.pop(context);
              if (currentScreen != DrawerSections.actions) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/actions', (_) => false);
              }
            },
          ),
        ],
      ),
    );
  }
}
