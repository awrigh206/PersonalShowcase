// ignore: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:showcase/Models/Project.dart';
import 'package:http/http.dart' as http;
import 'package:showcase/Widgets/Background.dart';
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
    return Scaffold(
      appBar: TopBar(),
      body: Stack(children: [
        Background(
          child: Container(
            child: Center(
                child: FutureBuilder<List<Project>>(
                    future: projects,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Project> realProjects =
                            snapshot.data as List<Project>;
                        return ListView.builder(
                            itemCount: realProjects.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(realProjects[index].title),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return ListTile(
                          title: Text(snapshot.error.toString()),
                          subtitle: Text(snapshot.error.runtimeType.toString()),
                          leading: Icon(Icons.error),
                        );
                      } else {
                        // ignore: prefer_const_constructors
                        return CircularProgressIndicator();
                      }
                    })),
          ),
        ),
      ]),
    );
  }

  Future<List<Project>> getProjects() async {
    var url = Uri.parse('https://localhost:9090/project');
    // List<Project> listOfProjects = List.empty();
    var response = await http.get(
      url,
      headers: {
        "Authorization": 'Basic YW5kcmV3OnBhc3N3b3Jk',
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var list = jsonDecode(response.body) as List;
    List<Project> projectList = list.map((i) => Project.fromJson(i)).toList();
    return projectList;
  }
}
