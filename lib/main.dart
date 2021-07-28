import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcase/Configuration/Config.dart';
import 'package:showcase/Models/TokenRequest.dart';
import 'Widgets/EmailForm.dart';
import 'Widgets/TopBar.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(const MyApp());
}

Future<void> setup() async {
  String token = await getToken();
  Config config =
      Config("https://localhost:9090/", token, 'Basic YW5kcmV3OnBhc3N3b3Jk');
  GetIt getIt = GetIt.instance;
  if (!getIt.isRegistered(instance: Config)) {
    getIt.registerSingleton<Config>(config, signalsReady: true);
  }

  return;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Showcase Site',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List isHovering = [false, false, false, false];
  TextStyle normalStyle = GoogleFonts.ubuntu(fontSize: 20);
  TextStyle hoverStyle = GoogleFonts.ubuntu(fontSize: 20, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    getListOfProjects();
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: TopBar(),
        body: Stack(
          children: [
            Container(color: Colors.grey[500]),
            Container(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: screenSize.width / 18),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    EmailForm(),
                  ],
                ),
              )),
            ),
          ],
        ));
  }

  Future<void> getListOfProjects() async {
    await setup();
    Config config = GetIt.I<Config>();
    var response =
        await http.get(Uri.parse(config.baseUrl + "project/list"), headers: {
      "Authorization": config.auth,
    });
    var list = jsonDecode(response.body);
    List<String> stringList = new List<String>.from(list);
    GetIt.I.registerSingleton<List<String>>(stringList, signalsReady: true);
  }
}

Future<String> getToken() async {
  var response = await http.post(Uri.parse("https://localhost:9090/token"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": 'Basic YW5kcmV3OnBhc3N3b3Jk',
      },
      body: jsonEncode(
          new TokenRequest('PUfKmpBmRbl53Az1jpNiICPWpJHstm1k').toJson()));
  return response.body;
}
