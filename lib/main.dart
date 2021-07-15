import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcase/Configuration/Config.dart';
import 'Widgets/TopBar.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(const MyApp());
}

Future<void> setup() async {
  String token = await getToken();
  Config config = Config("https://localhost:9090/", token);
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<Config>(config, signalsReady: true);
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
                child: Text('this is the home page'),
              ),
            ),
          ],
        ));
  }

  Future<void> getListOfProjects() async {
    await setup();
    var response = await http
        .get(Uri.parse(GetIt.I<Config>().baseUrl + "project/list"), headers: {
      "Authorization": 'Basic YW5kcmV3OnBhc3N3b3Jk',
    });
    var list = jsonDecode(response.body);
    List<String> stringList = new List<String>.from(list);
    GetIt.I.registerSingleton<List<String>>(stringList, signalsReady: true);
  }
}

Future<String> getToken() async {
  var response =
      await http.get(Uri.parse("https://localhost:9090/token"), headers: {
    "Authorization": 'Basic YW5kcmV3OnBhc3N3b3Jk',
  });
  return response.body;
}
