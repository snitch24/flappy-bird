// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class FlappyBird extends StatelessWidget {
  final birdYaxis;
  final double birdHeight;
  final double birdWidth;

  FlappyBird(
      {required this.birdHeight, required this.birdWidth, this.birdYaxis});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, (2 * birdYaxis + birdHeight) / (2 - birdHeight)),
      child: Image.asset(
        "images/flappy_bird.png",
        width: MediaQuery.of(context).size.height * birdWidth / 2,
        height: MediaQuery.of(context).size.width * 3 / 4 * birdHeight / 2,
        fit: BoxFit.fill,
      ),
    );
  }
}
