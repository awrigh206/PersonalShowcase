import 'package:flutter/material.dart';
import 'package:showcase/Models/Project.dart';
import 'package:showcase/Routes/SingleProjectRoute.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    if (project.images.isEmpty) {
      return ListTile(
        title: Text(project.title),
        leading: CircleAvatar(),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SingleProjectRoute(project: project)));
        },
      );
    } else {
      return ListTile(
        title: Text(project.title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(project.images.first.name),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SingleProjectRoute(project: project)));
        },
      );
    }
  }
}
