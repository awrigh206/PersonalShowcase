import 'package:showcase/Models/Image.dart';

class Project {
  String title;
  List<String> paragraphsOfContent;
  List<Image> images;

  Project(this.title, this.paragraphsOfContent, this.images);

  factory Project.fromJson(Map<String, dynamic> json) {
    var dynamicContentList = json['paragraphsOfContent'];

    String title = json['title'];
    List<String> content = new List<String>.from(dynamicContentList);
    var list = json['images'] as List;
    List<Image> imageList = list.map((i) => Image.fromJson(i)).toList();

    return new Project(title, content, imageList);
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'paragraphsOfContent': paragraphsOfContent,
        'images': images,
      };

  @override
  String toString() {
    return title;
  }
}
