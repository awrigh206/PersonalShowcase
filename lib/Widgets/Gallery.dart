// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:showcase/Models/Project.dart';
import 'package:showcase/Widgets/ImageDisplay.dart';
import 'package:transparent_image/transparent_image.dart';

class Gallery extends StatefulWidget {
  const Gallery({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Builder(builder: (context) {
            var screenSize = MediaQuery.of(context).size;
            if (screenSize.width > 900.0) {
              return Card(
                borderOnForeground: true,
                elevation: 20.0,
                shadowColor: Colors.blueGrey,
                child: ImageGrid(project: widget.project),
              );
            } else {
              return ImageGrid(project: widget.project);
            }
          })),
    );
  }
}

class ImageGrid extends StatefulWidget {
  const ImageGrid({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 450,
            childAspectRatio: 1,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15),
        itemCount: widget.project.images.length,
        itemBuilder: (context, index) {
          FadeInImage currentImage = FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: widget.project.images[index].route,
          );
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              child: Hero(
                  tag: 'image' + index.toString(),
                  child: ImageDisplay(
                    currentImage: currentImage,
                    index: index,
                  )),
            ),
          );
        });
  }
}
