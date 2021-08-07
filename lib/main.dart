import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcase/Configuration/Config.dart';
import 'Widgets/EmailForm.dart';
import 'Widgets/TopBar.dart';
import 'package:http/http.dart' as http;
import 'package:animated_text_kit/animated_text_kit.dart';

void main() async {
  setup();
  runApp(const MyApp());
}

setup() {
  Config config = Config(
      "http://51.145.3.232/", 'Basic YW5kcmV3OnBIdkhlZUxoODNiTllrSnhHYkNQ');
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
    return Scaffold(
        appBar: TopBar(),
        body: Stack(
          children: [
            Container(color: Colors.grey[500]),
            Container(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: screenSize.width / 18),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                            "Welcome to my personal website. This website contains information detailing previous projects that I have worked on. Feel free to explore my previous work and send me an email via the form below if you wish to get in touch.",
                            textStyle: animationTextStyle,
                            speed: Duration(milliseconds: 100)),
                      ],
                      totalRepeatCount: 1,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                    Divider(),
                    Expanded(child: EmailForm()),
                  ],
                ),
              )),
            ),
          ],
        ));
  }
}
