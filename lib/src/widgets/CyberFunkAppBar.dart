// ignore_for_file: use_build_context_synchronously, file_names

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CyberFunkAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CyberFunkAppBar({Key? key}) : super(key: key);

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
          child: InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? username = prefs.getString('username');
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[400],
                              child: const Icon(Icons.person_outline_sharp,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text("Usuario:"),
                              subtitle: Text(
                                username ?? 'Username',
                                // ignore: deprecated_member_use
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
              
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1.0),
              
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.person_outline_sharp,
                      color: Colors.black),
                ),
              )),
        )
      ],
      leading: IconButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        icon: const Icon(Icons.menu),
        color: Colors.black,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

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
