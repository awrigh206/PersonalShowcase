// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:showcase/Logic/BarLogic.dart';

import '../main.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer({Key? key}) : super(key: key);
  final BarLogic logic = BarLogic();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Showcase'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
            leading: const Icon(Icons.home),
          ),
          const Divider(),
          ListTile(
            title: const Text('Honours'),
            onTap: () {
              logic.navigateToHonours(context);
            },
            leading: const Icon(Icons.label_important),
          ),
          const Divider(),
          ListTile(
            title: const Text('Projects'),
            onTap: () {
              logic.getProjects(context);
            },
            leading: Icon(Icons.work),
          ),
          const Divider(),
          ListTile(
            title: const Text('CV'),
            onTap: () {
              logic.getPdf();
            },
            leading: const Icon(Icons.work),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
