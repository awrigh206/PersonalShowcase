import 'package:flutter/material.dart';
import 'package:showcase/Helpers/HttpHelper.dart';
import 'package:showcase/Models/Project.dart';
import 'package:showcase/Widgets/AsyncMarkdownDisplay.dart';
import 'package:showcase/Widgets/Background.dart';
import 'package:showcase/Widgets/Gallery.dart';
import 'package:showcase/Widgets/TopBar.dart';

class SingleProjectRoute extends StatelessWidget {
  final Project project;
  final NetworkImage mainImage;
  const SingleProjectRoute(
      {Key? key, required this.project, required NetworkImage this.mainImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<String> markdownFuture = HttpHelper.getMarkdownFromServer(project);
    return Scaffold(
      appBar: TopBar(),
      body: Background(
          child: Container(
        child: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
              color: Colors.transparent,
              child: Hero(
                tag: project.title,
                child: Image(
                  image: mainImage,
                  fit: BoxFit.cover,
                ),
              ),
            )),
            expandedHeight: 250,
            backgroundColor: Colors.blueGrey[300],
            actionsIconTheme: IconThemeData.fallback(),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
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
          ]))
        ]),
      )),
    );
  }
}
