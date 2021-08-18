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
          DrawerHeader(
            child: Text('Showcase'),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
            leading: Icon(Icons.home),
          ),
          Divider(),
          ListTile(
            title: Text('Honours'),
            onTap: () {
              logic.navigateToHonours(context);
            },
            leading: Icon(Icons.label_important),
          ),
          Divider(),
          ListTile(
            title: Text('Projects'),
            onTap: () {
              logic.getProjects(context);
            },
            leading: Icon(Icons.work),
          ),
          Divider(),
          ListTile(
            title: Text('CV'),
            onTap: () {
              logic.getPdf();
            },
            leading: Icon(Icons.work),
          ),
          Divider(),
        ],
      ),
    );
  }
}
