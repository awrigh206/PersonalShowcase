import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:showcase/Configuration/Config.dart';
import 'package:showcase/Models/Project.dart';

class HttpHelper {
  static Future<String> getMarkdownFromServer(Project project) async {
    Config config = GetIt.I<Config>();
    var url = Uri.parse(config.baseUrl + 'project/test');
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": config.auth,
        },
        body: jsonEncode(project.toJson()));
    var codec = utf8.fuse(base64);
    String raw = response.body;
    print(raw);
    raw = raw.replaceAll('\n', '');
    var decoded = codec.decode(raw);
    return decoded;
  }
}
