import 'package:flutter/material.dart';

class SingleImageRoute extends StatelessWidget {
  const SingleImageRoute(
      {Key? key, required this.displayImage, required this.index})
      : super(key: key);
  final FadeInImage displayImage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Stack(
          children: [
            Hero(
              tag: 'image' + index.toString(),
              child: Container(
                child: displayImage,
              ),
            ),
            IconButton(
                iconSize: 50,
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.black,
                splashColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.arrow_back)),
          ],
        ),
      ),
    );
  }
}
