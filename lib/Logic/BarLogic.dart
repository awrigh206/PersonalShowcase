import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:showcase/Configuration/Config.dart';
import 'package:showcase/Models/Project.dart';
import 'package:showcase/Routes/ProjectsPage.dart';
import 'package:showcase/Routes/SingleProjectRoute.dart';
import 'dart:html' as html;

class BarLogic {
  Future<void> getPdf() async {
    Config config = GetIt.I<Config>();
    var response = await http.get(Uri.parse(config.baseUrl + "file"), headers: {
      "Authorization": config.auth,
    });

    final blob = html.Blob([response.bodyBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, '_blank');
    html.Url.revokeObjectUrl(url);
  }

  Future<Project> getHonours() async {
    Config config = GetIt.I<Config>();
    var url = Uri.parse(config.baseUrl + 'project/find?title=Honours');
    var response = await http.get(
      url,
      headers: {
        "Authorization": config.auth,
      },
    );
    Project project = Project.fromJson(jsonDecode(response.body));
    return project;
  }

  void getProjects(var context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProjectsPage()));
  }

  Future<void> navigateToHonours(var context) async {
    Project honoursProject = await getHonours();
    NetworkImage mainImage = NetworkImage(honoursProject.images.first.route);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SingleProjectRoute(
                  project: honoursProject,
                  mainImage: mainImage,
                )));
  }
}
