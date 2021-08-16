import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcase/Configuration/Config.dart';
import 'package:http/http.dart' as http;
import 'package:showcase/Models/Project.dart';
import 'package:showcase/Routes/ProjectsPage.dart';
import 'package:showcase/Routes/SingleProjectRoute.dart';
import 'package:showcase/main.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  TopBar({Key? key}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();

  @override
  Size get preferredSize {
    return Size.fromHeight(60.0);
  }
}

class _TopBarState extends State<TopBar> {
  List isHovering = [false, false, false, false];
  TextStyle normalStyle = GoogleFonts.ubuntu(fontSize: 20);
  TextStyle hoverStyle = GoogleFonts.ubuntu(fontSize: 20, color: Colors.white);

  Color backgroundColor = Colors.white;
  double width = 50;
  double height = 50;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: Size(screenSize.width, screenSize.height / 10),
      child: Container(
        color: Colors.blueGrey[200],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              InkWell(
                child: const Text('Andrew Wright - Showcase'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                },
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        Project honoursProject = await getHonours();
                        NetworkImage mainImage =
                            NetworkImage(honoursProject.images.first.route);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SingleProjectRoute(
                                      project: honoursProject,
                                      mainImage: mainImage,
                                    )));
                      },
                      onHover: (value) {
                        setState(() {
                          isHovering[0] = value;
                        });
                      },
                      child: Text(
                        'Honours Project',
                        style: isHovering[0] ? hoverStyle : normalStyle,
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          isHovering[1] = value;
                          backgroundColor = Colors.greenAccent;
                        });
                      },
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProjectsPage()));
                      },
                      child: Text(
                        'Projects',
                        style: isHovering[1] ? hoverStyle : normalStyle,
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          isHovering[2] = value;
                        });
                      },
                      onTap: () async {
                        final bytes = await getPdfBytes();
                        final blob = html.Blob([bytes], 'application/pdf');
                        final url = html.Url.createObjectUrlFromBlob(blob);
                        html.window.open(url, '_blank');
                        html.Url.revokeObjectUrl(url);
                      },
                      child: Text(
                        'CV',
                        style: isHovering[2] ? hoverStyle : normalStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List> getPdfBytes() async {
    Config config = GetIt.I<Config>();
    var response = await http.get(Uri.parse(config.baseUrl + "file"), headers: {
      "Authorization": config.auth,
    });
    print(response.body);
    return response.bodyBytes;
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
}
