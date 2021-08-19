import 'package:flutter/material.dart';
import 'package:showcase/Models/Project.dart';
import 'package:showcase/Routes/SingleImageRoute.dart';
import 'package:transparent_image/transparent_image.dart';

class Gallery extends StatelessWidget {
  const Gallery({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          borderOnForeground: true,
          elevation: 20.0,
          shadowColor: Colors.blueGrey,
          child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 450,
                  childAspectRatio: 1,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15),
              itemCount: project.images.length,
              itemBuilder: (context, index) {
                FadeInImage currentImage = FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: project.images[index].route,
                );
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SingleImageRoute(
                                    displayImage: currentImage,
                                    index: index,
                                  )));
                    },
                    child: Hero(
                        tag: 'image' + index.toString(), child: currentImage),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
