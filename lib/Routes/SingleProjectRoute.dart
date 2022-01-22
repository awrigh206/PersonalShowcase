// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:showcase/Configuration/Config.dart';
import 'package:showcase/Helpers/HttpHelper.dart';
import 'package:showcase/Models/Commit.dart';
import 'package:showcase/Models/Project.dart';
import 'package:showcase/Widgets/AsyncCommitDisplay.dart';
import 'package:showcase/Widgets/AsyncMarkdownDisplay.dart';
import 'package:showcase/Widgets/BarBuilder.dart';
import 'package:showcase/Widgets/Gallery.dart';
import 'package:http/http.dart' as http;

class SingleProjectRoute extends StatelessWidget {
  final Project project;
  final NetworkImage mainImage;
  const SingleProjectRoute(
      {Key? key, required this.project, required this.mainImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<String> markdownFuture = HttpHelper.getMarkdownFromServer(project);

    Widget focus = CustomScrollView(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            primary: true,
            stretch: true,
            iconTheme: const IconThemeData(
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
            actionsIconTheme: const IconThemeData.fallback(),
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
            AsyncCommitDisplay(
                project: project, commitFuture: fetchCommitsForProject()),
          ]))
        ]);

    return BarBuilder(focusWidget: focus);
  }

  Future<List<Commit>> fetchCommitsForProject() async {
    Config config = GetIt.I<Config>();
    var url =
        Uri.parse(config.baseUrl + 'project/commit?title=' + project.title);
    var response = await http.get(
      url,
      headers: {
        "Authorization": config.auth,
      },
    );
    var list = jsonDecode(response.body) as List;
    List<Commit> commitList = list.map((i) => Commit.fromJson(i)).toList();
    return commitList;
  }
}
