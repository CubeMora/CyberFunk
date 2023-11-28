import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.greenAccent,
            ),
            child: Text('Módulos'),
          ),
          ListTile(
            title: const Text('Módulo 1'),
            onTap: () {
              
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
            },
          ),
          ListTile(
            title: const Text('Módulo 2'),
            onTap: () {
             
              Navigator.pop(context);
              Navigator.pushNamed(context, '/blog',);
            },
          ),
          ListTile(
            title: const Text('Módulo 3'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}