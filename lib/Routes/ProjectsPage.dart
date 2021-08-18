import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:showcase/Configuration/Config.dart';
import 'package:showcase/Models/Project.dart';
import 'package:http/http.dart' as http;
import 'package:showcase/Widgets/Background.dart';
import 'package:showcase/Widgets/BarBuilder.dart';
import 'package:showcase/Widgets/ProjectTile.dart';
import 'package:showcase/Widgets/TopBar.dart';

class ProjectsPage extends StatefulWidget {
  ProjectsPage({Key? key}) : super(key: key);

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    Future<List<Project>> projects = getProjects();

    Widget focus = Center(
      child: FutureBuilder<List<Project>>(
          future: projects,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Project> realProjects = snapshot.data as List<Project>;
              return ListView.builder(
                  itemCount: realProjects.length,
                  itemBuilder: (context, index) {
                    return ProjectTile(project: realProjects[index]);
                  });
            } else if (snapshot.hasError) {
              return ListTile(
                title: Text(snapshot.error.toString()),
                subtitle: Text(snapshot.error.runtimeType.toString()),
                leading: Icon(Icons.error),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );

    return BarBuilder(focusWidget: focus);
  }

  Future<List<Project>> getProjects() async {
    Config config = GetIt.I<Config>();
    var url = Uri.parse(config.baseUrl + 'project/list');
    var response = await http.get(
      url,
      headers: {
        "Authorization": config.auth,
      },
    );
    var list = jsonDecode(response.body) as List;
    List<Project> projectList = list.map((i) => Project.fromJson(i)).toList();
    return projectList;
  }
}
