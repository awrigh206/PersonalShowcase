import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'EmailForm.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key? key,
    required this.animationTextStyle,
  }) : super(key: key);

  final TextStyle animationTextStyle;

  @override
  Widget build(BuildContext context) {
    return ListView(
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
    );
  }
}
