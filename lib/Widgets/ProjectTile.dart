import 'package:flutter/material.dart';
import 'package:showcase/Models/Project.dart';
import 'package:showcase/Routes/SingleProjectRoute.dart';
import 'dart:html' as html;

class ProjectTile extends StatelessWidget {
  const ProjectTile({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    final userAgent = html.window.navigator.userAgent.toString().toLowerCase();
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
        if (project.tagList.isNotEmpty &&
            !userAgent.contains('android') &&
            !userAgent.contains('ios')) {
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
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: project.tagList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueAccent),
                        ),
                        onPressed: () {},
                        child: Text(
                          project.tagList[index].name,
                          style: TextStyle(color: Colors.white),
                        )),
                  );
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
