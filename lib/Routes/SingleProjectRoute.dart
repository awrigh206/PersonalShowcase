import 'package:flutter/material.dart';
import 'package:showcase/Models/Project.dart';
import 'package:showcase/Widgets/Background.dart';
import 'package:showcase/Widgets/TopBar.dart';

class SingleProjectRoute extends StatelessWidget {
  final Project project;
  const SingleProjectRoute({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Background(
          child: Container(
        child: Text("Hello there, I am "),
      )),
    );
  }
}
