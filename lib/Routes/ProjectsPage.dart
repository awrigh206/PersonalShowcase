// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:showcase/Configuration/Config.dart';
import 'package:showcase/Models/Project.dart';
import 'package:http/http.dart' as http;
import 'package:showcase/Widgets/BarBuilder.dart';
import 'package:showcase/Widgets/ProjectTile.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

typedef void StringCallback(String tag);

class _ProjectsPageState extends State<ProjectsPage> {
  TextEditingController controller = TextEditingController();
  String searchText = '';
  String dropdownValue = 'Select a Tag';
  late Future<List<Project>> projects;

  @override
  void initState() {
    super.initState();
    projects = getProjects();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget focus = Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                onChanged: (text) {
                  setState(() {
                    searchText = text;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  FutureBuilder(
                      future: projects,
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          List<Project> realProjects =
                              snapshot.data as List<Project>;
                          List<String> availableTags = getAllTags(realProjects);
                          return DropdownButton<String>(
                            hint: const Text('Select a tag to filter'),
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 32,
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.blueAccent, fontSize: 18),
                            underline: Container(
                              height: 2,
                              color: Colors.blueAccent,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: availableTags
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          );
                        } else {
                          return const Text('Loading Tags');
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
        FutureBuilder<List<Project>>(
            future: projects,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                List<Project> realProjects = snapshot.data as List<Project>;
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: realProjects.length,
                    itemBuilder: (context, index) {
                      if (dropdownValue != 'Select a Tag') {
                        List<String> singleProjectTags =
                            getTagsFromProject(realProjects[index]);
                        if (singleProjectTags.contains(dropdownValue)) {
                          return ProjectTile(
                            project: realProjects[index],
                            onChange: tagChange,
                          );
                        }
                      } else if (searchText.isNotEmpty &&
                          realProjects[index]
                              .title
                              .toLowerCase()
                              .contains(searchText.toLowerCase())) {
                        return ProjectTile(
                          project: realProjects[index],
                          onChange: tagChange,
                        );
                      } else if (searchText.isEmpty) {
                        return ProjectTile(
                          project: realProjects[index],
                          onChange: tagChange,
                        );
                      } else {
                        return Container();
                      }
                      return Container();
                    });
              } else if (snapshot.hasError) {
                return ListTile(
                  title: Text(snapshot.error.toString()),
                  subtitle: Text(snapshot.error.runtimeType.toString()),
                  leading: const Icon(Icons.error),
                );
              } else {
                return const CircularProgressIndicator();
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

  List<String> getAllTags(List<Project> projects) {
    List<String> tagList = List<String>.empty(growable: true);
    for (int i = 0; i < projects.length; i++) {
      log('list: ' + projects[i].toString());
      if (projects[i].tagList.isNotEmpty) {
        for (int j = 0; j < projects[i].tagList.length; j++) {
          if (!tagList.contains(projects[i].tagList[j].name)) {
            tagList.add(projects[i].tagList[j].name);
          }
        }
      }
    }
    tagList.add("Select a Tag");
    return tagList;
  }

  List<String> getTagsFromProject(Project project) {
    List<String> tagList = List<String>.empty(growable: true);
    for (int j = 0; j < project.tagList.length; j++) {
      tagList.add(project.tagList[j].name);
    }
    return tagList;
  }

  void tagChange(String text) {
    setState(() {
      dropdownValue = text;
    });
  }
}
