import 'package:flutter/material.dart';
import 'package:security_info_project/src/widgets/AppDrawer.dart';
import 'package:security_info_project/src/widgets/CyberFunkAppBar.dart';
import 'package:shaky_animated_listview/animators/grid_animator.dart';

class ActionsListScreen extends StatefulWidget {
  const ActionsListScreen({super.key});

  @override
  State<ActionsListScreen> createState() => _ActionsListScreenState();
}

class _ActionsListScreenState extends State<ActionsListScreen> {
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
            child: ActionsGridView(),
          ),
        ),
      )
        ],
      ),
    );
  }

  GridView ActionsGridView() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      children: List.generate(
        9,
        (i) => GridAnimatorWidget(
          
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ).toList(),
    );
  }
}
