// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:showcase/Widgets/Background.dart';
import 'package:showcase/Widgets/WaveWidget.dart';
import 'dart:html' as html;
import 'SideDrawer.dart';
import 'TopBar.dart';

class BarBuilder extends StatelessWidget {
  const BarBuilder({Key? key, required Widget this.focusWidget})
      : super(key: key);
  final Widget focusWidget;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        var screenSize = MediaQuery.of(context).size;
        final userAgent =
            html.window.navigator.userAgent.toString().toLowerCase();
        Container mainBody = Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: screenSize.width / 18),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: focusWidget,
          )),
        );

        Container noMarginBody = Container(
          color: Colors.white,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: focusWidget,
          )),
        );

        if (userAgent.contains("android") ||
            userAgent.contains("ios") ||
            userAgent.toLowerCase().contains("iphone")) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Showcase'),
              actions: [],
            ),
            body: noMarginBody,
            drawer: SideDrawer(),
          );
        } else {
          return Scaffold(
            appBar: const WaveWidget(focusWidget: TopBar()),
            body: Builder(builder: (context) {
              if (screenSize.width < 900.0) {
                return mainBody;
              } else {
                return Background(child: noMarginBody);
              }
            }),
          );
        }
      },
    );
  }
}
