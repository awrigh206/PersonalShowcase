import 'package:showcase/Models/Image.dart';
import 'package:showcase/Models/Tag.dart';

class Project {
  String title;
  List<String> paragraphsOfContent;
  List<Image> images;
  List<Tag> tagList;

  Project(this.title, this.paragraphsOfContent, this.images, this.tagList);

  factory Project.fromJson(Map<String, dynamic> json) {
    var dynamicContentList = json['paragraphsOfContent'];

    String title = json['title'];
    List<String> content = new List<String>.from(dynamicContentList);
    var list = json['images'] as List;
    List<Image> imageList = list.map((i) => Image.fromJson(i)).toList();
    List<Tag> tagList = new List.empty();
    try {
      tagList = list.map((i) => Tag.fromJson(i)).toList();
    } catch (e) {}

    return new Project(title, content, imageList, tagList);
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
