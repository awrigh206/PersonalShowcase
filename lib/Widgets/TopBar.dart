import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcase/Routes/ProjectsPage.dart';

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
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color: Colors.blueGrey[200],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const Text('Andrew Wright - Showcase'),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
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
                        'Other Projects',
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
                      onTap: () {},
                      child: Text(
                        'Important Links',
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
