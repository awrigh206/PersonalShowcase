// ignore_for_file: file_names
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
    var imageJsonList = json['images'] as List;
    List<Image> imageList =
        imageJsonList.map((i) => Image.fromJson(i)).toList();
    List<Tag> tagList = new List.empty();
    try {
      var tagJsonList = json['tagList'] as List;
      tagList = tagJsonList.map((i) => Tag.fromJson(i)).toList();
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
