class Tag {
  String name;
  int weighting;

  Tag(this.name, this.weighting);

  Tag.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        weighting = json['weighting'];

  Map<String, dynamic> toJson() => {'name': name, 'weighting': weighting};

  @override
  String toString() {
    return name;
  }
}
