import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:showcase/Configuration/Config.dart';
import 'package:showcase/Models/Email.dart';
import 'package:http/http.dart' as http;

class EmailLogic {
  Future<void> sendEmail(Email email) async {
    Config config = GetIt.I<Config>();
    var response = await http.post(
      Uri.parse(config.baseUrl + 'email'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': config.auth,
      },
      body: jsonEncode(email),
    );
  }

  Future<LottieComposition> fetchAnimation() async {
    var assetData = await rootBundle.load('Assets/sent.json');
    return await LottieComposition.fromByteData(assetData);
  }
}
