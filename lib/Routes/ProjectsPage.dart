import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
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
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://raw.githubusercontent.com/awrigh206/TestRepo/main/HappyFace.jpg"),
                              ),
                              onTap: () {},
                            );
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
            ),
          ),
        ),
      ]),
    );
  }

  Future<List<Project>> getProjects() async {
    var url = Uri.parse(GetIt.I<String>() + 'project');
    // List<Project> listOfProjects = List.empty();
    var response = await http.get(
      url,
      headers: {
        "Authorization": 'Basic YW5kcmV3OnBhc3N3b3Jk',
      },
    );
    var list = jsonDecode(response.body) as List;
    List<Project> projectList = list.map((i) => Project.fromJson(i)).toList();
    return projectList;
  }
}
