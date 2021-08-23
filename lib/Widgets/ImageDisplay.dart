import 'package:flutter/material.dart';
import 'package:showcase/Routes/SingleImageRoute.dart';

class ImageDisplay extends StatefulWidget {
  ImageDisplay({Key? key, required this.currentImage, required this.index})
      : super(key: key);
  final FadeInImage currentImage;
  final int index;

  @override
  _ImageDisplayState createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay>
    with SingleTickerProviderStateMixin {
  late Animation sizeAnimation;
  late AnimationController controller;
  double imageSize = 1;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    sizeAnimation = Tween(begin: 0.0, end: 40.0).animate(controller);
    sizeAnimation.addListener(() {
      setState(() {
        imageSize = sizeAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: imageSize,
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SingleImageRoute(
                            displayImage: widget.currentImage,
                            index: widget.index,
                          )));
            },
            onHover: (isHovering) {
              if (isHovering) {
                controller.forward();
              } else {
                controller.reverse();
              }
            },
            child: widget.currentImage));
  }
}
