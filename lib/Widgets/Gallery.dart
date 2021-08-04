import 'package:flutter/material.dart';
import 'package:showcase/Models/Project.dart';
import 'package:transparent_image/transparent_image.dart';

class Gallery extends StatelessWidget {
  const Gallery({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 450,
                childAspectRatio: 1,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15),
            itemCount: project.images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: project.images[index].route,
                ),
              );
            }),
      ),
    );
  }
}
