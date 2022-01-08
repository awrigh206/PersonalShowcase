// ignore_for_file: file_names
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:showcase/Models/TetrisGame.dart';

class MyGameWidget extends StatefulWidget {
  const MyGameWidget({Key? key}) : super(key: key);

  @override
  _MyGameWidgetState createState() => _MyGameWidgetState();
}

class _MyGameWidgetState extends State<MyGameWidget> {
  @override
  Widget build(BuildContext context) {
    print("goes into game widget");
    TetrisGame tetris = TetrisGame();
    runApp(GameWidget(game: tetris));
    return const Text('Game goes here');
  }
}
