import 'package:get_it/get_it.dart';
import 'package:showcase/Configuration/Config.dart';

class Image {
  String name;
  late String route;

  Image(this.name) {
    GetIt getIt = GetIt.I;
    this.route = getIt.get<Config>().baseUrl + 'image?name=' + name;
  }

  Image.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        route = 'https://51.143.243.36:9090/image?name=' + json['name'];

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
