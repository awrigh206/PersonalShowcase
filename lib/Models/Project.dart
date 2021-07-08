class Project {
  String title;
  List<String> paragraphsOfContent;
  List<String> images;

  Project(this.title, this.paragraphsOfContent, this.images);

  factory Project.fromJson(Map<String, dynamic> json) {
    var dynamicContentList = json['paragraphsOfContent'];
    var dynmaicImageList = json['images'];

    return new Project(json['title'], new List<String>.from(dynamicContentList),
        new List<String>.from(dynmaicImageList));
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
