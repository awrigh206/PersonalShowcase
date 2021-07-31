import 'package:flutter/material.dart';
import 'package:showcase/Helpers/HttpHelper.dart';
import 'package:showcase/Models/Project.dart';
import 'package:showcase/Widgets/AsyncMarkdownDisplay.dart';
import 'package:showcase/Widgets/Background.dart';
import 'package:showcase/Widgets/Gallery.dart';
import 'package:showcase/Widgets/TopBar.dart';

class SingleProjectRoute extends StatelessWidget {
  final Project project;
  const SingleProjectRoute({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<String> markdownFuture = HttpHelper.getMarkdownFromServer(project);
    return Scaffold(
      appBar: TopBar(),
      body: Background(
          child: Container(
        child: Column(
          children: [
            AsyncMarkdownDisplay(textFuture: markdownFuture),
            FutureBuilder(
                future: markdownFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Gallery(project: project);
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      )),
    );
  }
}
