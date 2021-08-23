import 'package:flutter/material.dart';
import 'package:showcase/Helpers/WaveClipper.dart';

class WaveWidget extends StatefulWidget implements PreferredSizeWidget {
  WaveWidget({Key? key, required this.focusWidget}) : super(key: key);
  final Widget focusWidget;

  @override
  _WaveWidgetState createState() => _WaveWidgetState();

  @override
  Size get preferredSize {
    return Size.fromHeight(150.0);
  }
}

class _WaveWidgetState extends State<WaveWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation waveAnimation;
  late double value;

  @override
  void initState() {
    super.initState();
    value = 100.0;
    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    waveAnimation = Tween(begin: 90.0, end: 500.0).animate(controller);

    waveAnimation.addListener(() {
      setState(() {
        value = waveAnimation.value;
      });
      if (waveAnimation.isCompleted) {
        controller.reverse();
      } else if (waveAnimation.isDismissed) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onDoubleTap: () {},
        onHover: (isHovering) {
          if (isHovering) {
            controller.forward();
          } else {
            controller.stop();
          }
        },
        child: Container(
            child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.1,
              child: Container(
                color: Theme.of(context).accentColor,
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: ClipPath(
                clipper: WaveClipper(value),
                child: Container(
                  color: Theme.of(context).accentColor,
                  height: 150,
                ),
              ),
            ),
            ClipPath(
                clipper: WaveClipper(waveAnimation.value),
                child: Container(
                  padding: EdgeInsets.only(bottom: 50),
                  color: Theme.of(context).primaryColor,
                  height: 125,
                  alignment: Alignment.center,
                  child: widget.focusWidget,
                )),
          ],
        )),
      ),
    );
  }
}
