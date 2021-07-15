import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpHelper {
  static Future<String> getMarkdownFromGithub(String address) async {
    var url = Uri.parse(address);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader:
          "Bearer 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",
    });
    var codec = utf8.fuse(base64);
    String raw = jsonDecode(response.body)['content'];
    raw = raw.replaceAll('\n', '');
    print('The raw: ' + raw);
    var decoded = codec.decode(raw);
    return decoded;
  }
}
