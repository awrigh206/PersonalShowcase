import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Widgets/TopBar.dart';
import 'package:http/http.dart' as http;

void main() {
  setup();
  runApp(const MyApp());
}

void setup() {
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<String>("https://localhost:9090/",
      signalsReady: true);
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
    GetIt getIt = GetIt.instance;
    getListOfProjects();
    Future<String> mardownFuture = getMarkdownFromGithub();
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
                child: FutureBuilder(
                    future: mardownFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String text = snapshot.data as String;
                        return Markdown(data: text);
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
            ),
          ],
        ));
  }

  Future<void> getListOfProjects() async {
    var response =
        await http.get(Uri.parse(GetIt.I<String>() + "project/list"), headers: {
      "Authorization": 'Basic YW5kcmV3OnBhc3N3b3Jk',
    });
    var list = jsonDecode(response.body);
    List<String> stringList = new List<String>.from(list);
    GetIt.I.registerSingleton<List<String>>(stringList, signalsReady: true);
  }

  Future<String> getMarkdownFromGithub() async {
    String address =
        "https://raw.githubusercontent.com/awrigh206/TestRepo/main/example.md";
    var url = Uri.parse(address);
    var response = await http.get(url);
    return response.body;
  }
}
