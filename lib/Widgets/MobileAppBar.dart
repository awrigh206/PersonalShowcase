// ignore_for_file: file_names
import 'package:flutter/material.dart';

class MobileAppBar extends StatefulWidget {
  MobileAppBar({Key? key}) : super(key: key);

  @override
  _MobileAppBarState createState() => _MobileAppBarState();
}

class _MobileAppBarState extends State<MobileAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [],
      title: const Text('Showcase'),
    );
  }
}
