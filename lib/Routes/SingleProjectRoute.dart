// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:showcase/Helpers/HttpHelper.dart';
import 'package:showcase/Models/Project.dart';
import 'package:showcase/Widgets/AsyncCommitDisplay.dart';
import 'package:showcase/Widgets/AsyncMarkdownDisplay.dart';
import 'package:showcase/Widgets/BarBuilder.dart';
import 'package:showcase/Widgets/Gallery.dart';

class SingleProjectRoute extends StatelessWidget {
  final Project project;
  final NetworkImage mainImage;
  SingleProjectRoute(
      {Key? key, required this.project, required NetworkImage this.mainImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<String> markdownFuture = HttpHelper.getMarkdownFromServer(project);

    Widget focus = CustomScrollView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            primary: true,
            stretch: true,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
              color: Colors.white,
              child: Hero(
                tag: project.title,
                child: Image(
                  image: mainImage,
                  fit: BoxFit.cover,
                ),
              ),
            )),
            expandedHeight: 500,
            backgroundColor: Colors.blueGrey[300],
            actionsIconTheme: IconThemeData.fallback(),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            AsyncMarkdownDisplay(
              textFuture: markdownFuture,
            ),
            FutureBuilder(
                future: markdownFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Gallery(project: project);
                  } else {
                    return Container();
                  }
                }),
            AsyncCommitDisplay(project: project),
          ]))
        ]);

    return BarBuilder(focusWidget: focus);
  }
}
