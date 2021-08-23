import 'package:flutter/material.dart';
import 'package:showcase/Helpers/WaveClipper.dart';

class WaveWidget extends StatelessWidget implements PreferredSizeWidget {
  const WaveWidget({Key? key, required this.focusWidget}) : super(key: key);
  final Widget focusWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: WaveClipper(),
            child: Container(
              color: Theme.of(context).accentColor,
              height: 200,
            ),
          ),
        ),
        ClipPath(
            clipper: WaveClipper(),
            child: Container(
              padding: EdgeInsets.only(bottom: 50),
              color: Theme.of(context).primaryColor,
              height: 180,
              alignment: Alignment.center,
              child: focusWidget,
            )),
      ],
    ));
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(200.0);
  }
}
