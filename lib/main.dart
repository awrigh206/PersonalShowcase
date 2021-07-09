import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Widgets/TopBar.dart';

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
                child: Column(
                  children: [
                    ElevatedButton(
                        child: Text("Test Button"), onPressed: () {}),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          getIt<String>() + 'image?name=HappyFace.jpg',
                          headers: {
                            "authorization": "Basic YW5kcmV3OnBhc3N3b3Jk"
                          }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
