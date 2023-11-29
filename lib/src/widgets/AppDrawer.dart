import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

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
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
            },
          ),
          ListTile(
            title: const Text('Módulo 2'),
            subtitle: const Text('Blogs sobre ciberseguridad'),
            leading: const Icon(Icons.newspaper_rounded),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                '/blog',
              );
            },
          ),
          ListTile(
            title: const Text('Módulo 3'),
            subtitle: const Text('Actos de prevención y respuesta'),
            leading: const Icon(Icons.shield_outlined),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/actions');
            },
          ),
          // const Divider(
          //   thickness: 3.0,
          // ),
          
          
        ],
      ),
    );
  }
}
