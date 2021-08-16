import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcase/Configuration/Config.dart';
import 'package:showcase/Widgets/Background.dart';
import 'package:showcase/Widgets/MobileAppBar.dart';
import 'Widgets/EmailForm.dart';
import 'Widgets/TopBar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:html' as html;

import 'Widgets/WelcomeText.dart';

void main() async {
  setup();
  runApp(const MyApp());
}

setup() {
  Config config = Config("https://awrigh206.me:9090/",
      'Basic YW5kcmV3OnBIdkhlZUxoODNiTllrSnhHYkNQ');
  GetIt getIt = GetIt.instance;
  if (!getIt.isRegistered(instance: Config)) {
    getIt.registerSingleton<Config>(config, signalsReady: true);
  }

  return;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Showcase Site',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List isHovering = [false, false, false, false];
  TextStyle normalStyle = GoogleFonts.ubuntu(fontSize: 20);
  TextStyle hoverStyle = GoogleFonts.ubuntu(fontSize: 20, color: Colors.white);
  TextStyle animationTextStyle =
      GoogleFonts.courierPrime(fontSize: 20, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final userAgent = html.window.navigator.userAgent.toString().toLowerCase();
    Container mainBody = Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: screenSize.width / 18),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: WelcomeText(animationTextStyle: animationTextStyle),
      )),
    );

    return Builder(
      builder: (context) {
        if (userAgent.contains("android") || userAgent.contains("ios")) {
          return Scaffold(
            appBar: AppBar(title: Text('Showcase')),
            body: mainBody,
          );
        } else {
          return Scaffold(
            appBar: TopBar(),
            body: Builder(builder: (context) {
              if (screenSize.width < 900.0) {
                return mainBody;
              } else {
                return Background(child: mainBody);
              }
            }),
          );
        }
      },
    );
  }
}
