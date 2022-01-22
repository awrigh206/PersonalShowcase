// ignore_for_file: file_names
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcase/Logic/BarLogic.dart';
import 'package:showcase/main.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();

  @override
  Size get preferredSize {
    return const Size.fromHeight(60.0);
  }
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin {
  List isHovering = [false, false, false, false];
  TextStyle normalStyle = GoogleFonts.ubuntu(fontSize: 20);
  TextStyle hoverStyle = GoogleFonts.ubuntu(fontSize: 20, color: Colors.white);
  BarLogic logic = BarLogic();

  late Animation colorAnimation;
  late Color color;
  late AnimationController controller;
  late Animation sizeAnimation;
  late double textSize;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    colorAnimation =
        ColorTween(begin: Colors.black, end: Colors.white).animate(controller);
    sizeAnimation = Tween(begin: 15.0, end: 22.0).animate(controller);
    color = Colors.black;
    textSize = 15.0;
    colorAnimation.addListener(() {
      setState(() {
        color = colorAnimation.value;
      });
    });

    sizeAnimation.addListener(() {
      setState(() {
        textSize = sizeAnimation.value;
      });
    });
  }

  Color backgroundColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            InkWell(
              child: Text('Andrew Wright - Showcase',
                  style: TextStyle(color: color, fontSize: textSize)),
              onHover: (value) {
                if (value) {
                  controller.forward();
                } else {
                  controller.reverse();
                }
              },
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage()));
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
    );
  }
}
