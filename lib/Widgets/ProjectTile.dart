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
      return Builder(builder: (context) {
        if (project.tagList.isNotEmpty) {
          return ListTile(
            title: Text(project.title),
            leading: Hero(
              tag: project.title,
              child: CircleAvatar(
                backgroundImage: mainImage,
                backgroundColor: Colors.white,
              ),
            ),
            trailing: ListView.builder(
                itemCount: project.tagList.length,
                itemBuilder: (context, index) {
                  return Text(project.tagList[index].name);
                }),
            onTap: () {
              goToProjectPage(project, mainImage, context);
            },
          );
        } else {
          return ListTile(
            title: Text(project.title),
            leading: Hero(
              tag: project.title,
              child: CircleAvatar(
                backgroundImage: mainImage,
                backgroundColor: Colors.white,
              ),
            ),
            onTap: () {
              goToProjectPage(project, mainImage, context);
            },
          );
        }
      });
    }
  }
}

void goToProjectPage(Project project, NetworkImage mainImage, dynamic context) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SingleProjectRoute(
                project: project,
                mainImage: mainImage,
              )));
}
