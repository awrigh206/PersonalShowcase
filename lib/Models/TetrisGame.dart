// ignore_for_file: file_names

import 'dart:ui';

import 'package:flame/game.dart';

class TetrisGame extends FlameGame {
  late Size screenSize;

  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574);
    canvas.drawRect(bgRect, bgPaint);
  }

  void update(double t) {}

  void resize(Size size) {
    screenSize = size;
  }
}
