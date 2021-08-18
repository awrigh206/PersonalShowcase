import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcase/Configuration/Config.dart';
import 'package:showcase/Widgets/Background.dart';
import 'package:showcase/Widgets/BarBuilder.dart';
import 'package:showcase/Widgets/SideDrawer.dart';
import 'Widgets/TopBar.dart';
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

  @override
  Widget build(BuildContext context) {
    return BarBuilder(focusWidget: WelcomeText());
  }
}
