import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:security_info_project/src/models/infography.dart';
import 'package:security_info_project/src/widgets/AppDrawer.dart';
import 'package:security_info_project/src/widgets/CyberFunkAppBar.dart';
import 'package:shaky_animated_listview/animators/grid_animator.dart';

class ActionsListScreen extends StatefulWidget {
  const ActionsListScreen({super.key});

  @override
  State<ActionsListScreen> createState() => _ActionsListScreenState();
}

class _ActionsListScreenState extends State<ActionsListScreen> {
  List<Infography> infography = [
    Infography(
        title: "Seguridad en línea",
        image: "assets/images/infography/infography_online_security.jpg",
        description: "A ta perrotototototototototototototototototote"),
    Infography(
        title: "Ataques de phishing",
        image: "assets/images/infography/infography_phishing.jpg",
        description: "A ta perrotototototototototototototototototote"),
    Infography(
        title: "Fraudes en línea",
        image: "assets/images/infography/infografy_iot_security.jpg",
        description: "A ta perrotototototototototototototototototote"),
    Infography(
        title: "Identidad personal",
        image: "assets/images/infography/infography_personal_identity.jpg",
        description: "A ta perrotototototototototototototototototote"),
    Infography(
        title: "Contraseñas",
        image: "assets/images/infography/infography_secure_passwords.jpg",
        description: "A ta perrotototototototototototototototototote"),
    Infography(
        title: "Actualizaciones",
        image: "assets/images/infography/infography_updates_importance.jpg",
        description: "A ta perrotototototototototototototototototote"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CyberFunkAppBar(),
      drawer: const AppDrawer(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            title: Text("Módulo 3"),
            subtitle: Text("Actos de prevención y respuesta"),
            leading: Icon(Icons.shield_outlined),
          ),
          const Divider(
            indent: 30.0,
            endIndent: 30.0,
            thickness: 1.5,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: actionsGridView(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget actionsGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 350, mainAxisExtent: 520
          //childAspectRatio: 3 / 2, // Adjust this ratio to fix the image height
          ),
      itemCount: infography.length,
      itemBuilder: (context, index) {
        return GridAnimatorWidget(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: InkWell(
              onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfographyScreen(
                    img: infography[index].image,
                  ),
                ),
              );
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  children: [
                    Hero(
                      tag: infography[index].image,
                      child: Image.asset(
                        infography[index].image,
                        fit: BoxFit.cover,

                        //height: 30.0,
                      )
                          ,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          infography[index].title,
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        )
                            .animate()
                            .fadeIn(duration: const Duration(seconds: 2)),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: const Duration(seconds: 1)),
            ),
          ),
        );
      },
    );
  }
}

class InfographyScreen extends StatelessWidget {
  const InfographyScreen({super.key, required this.img});

  final String img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: const Color.fromRGBO(52, 51, 58, 0.96),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            child: const Icon(Icons.arrow_back),
          ).animate().fadeIn(duration: const Duration(milliseconds: 500)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: SingleChildScrollView(
          child: Hero(
            tag: img,
            child: Image.asset(img),
          ),
        ));
  }
}
