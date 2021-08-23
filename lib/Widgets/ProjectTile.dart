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
    NetworkImage mainImage = NetworkImage(project.images.first.route);
    if (project.images.isEmpty) {
      return ListTile(
        title: Text(project.title),
        leading: CircleAvatar(),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SingleProjectRoute(
                      project: project, mainImage: mainImage)));
        },
      );
    } else {
      return ListTile(
        title: Text(project.title),
        leading: Hero(
          tag: project.title,
          child: CircleAvatar(
            backgroundImage: mainImage,
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SingleProjectRoute(
                        project: project,
                        mainImage: mainImage,
                      )));
        },
      );
    }
  }
}
