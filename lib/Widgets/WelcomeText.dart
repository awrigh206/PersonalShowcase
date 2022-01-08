// ignore_for_file: file_names
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcase/Widgets/GameWidget.dart';
import 'EmailForm.dart';

class WelcomeText extends StatefulWidget {
  WelcomeText({
    Key? key,
  }) : super(key: key);

  @override
  _WelcomeTextState createState() => _WelcomeTextState();
}

typedef void BoolCallback(bool game);

class _WelcomeTextState extends State<WelcomeText> {
  final TextStyle animationTextStyle =
      GoogleFonts.courierPrime(fontSize: 20, color: Colors.black);

  bool run = false;

  @override
  Widget build(BuildContext context) {
    if (!run) {
      return ListView(
        shrinkWrap: true,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                  "Welcome to my personal website. This website contains information detailing previous projects that I have worked on. Feel free to explore my previous work and send me an email via the form below if you wish to get in touch.",
                  textStyle: animationTextStyle,
                  speed: const Duration(milliseconds: 100)),
            ],
            totalRepeatCount: 1,
            pause: const Duration(milliseconds: 1000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
          Divider(),
          EmailForm(
            onChange: game,
          ),
        ],
      );
    } else {
      return const MyGameWidget();
    }
  }

  void game(String text) {
    setState(() {
      run = true;
    });
  }
}
