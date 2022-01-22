// ignore_for_file: file_names
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Container child;
  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Stack(children: [
      Container(color: Colors.grey[500]),
      Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: screenSize.width / 18),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width / 18),
        child: child,
      ),
    ]);
  }
}
