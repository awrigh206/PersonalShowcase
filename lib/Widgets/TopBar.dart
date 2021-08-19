import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcase/Logic/BarLogic.dart';
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
  BarLogic logic = BarLogic();

  Color backgroundColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: Size(screenSize.width, screenSize.height / 9),
      child: Container(
        color: Colors.blueGrey[200],
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                        await logic.navigateToHonours(context);
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
                        logic.getProjects(context);
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
                        await logic.getPdf();
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
}
