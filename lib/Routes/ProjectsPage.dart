import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:showcase/Configuration/Config.dart';
import 'package:showcase/Models/Project.dart';
import 'package:http/http.dart' as http;
import 'package:showcase/Widgets/BarBuilder.dart';
import 'package:showcase/Widgets/ProjectTile.dart';

class ProjectsPage extends StatefulWidget {
  ProjectsPage({Key? key}) : super(key: key);

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  TextEditingController controller = TextEditingController();
  String searchText = "";

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Project>> projects = getProjects();

    Widget focus = Column(
      children: [
        TextField(
          controller: controller,
          decoration: new InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0))),
          onChanged: (text) {
            setState(() {
              searchText = text;
            });
          },
        ),
        FutureBuilder<List<Project>>(
            future: projects,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Project> realProjects = snapshot.data as List<Project>;
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: realProjects.length,
                    itemBuilder: (context, index) {
                      print(searchText);
                      if (searchText.isNotEmpty &&
                          realProjects[index].title.contains(searchText)) {
                        return ProjectTile(project: realProjects[index]);
                      } else if (searchText.isEmpty) {
                        return ProjectTile(project: realProjects[index]);
                      }
                      return Container();
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
      ],
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
