// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class FlappyBird extends StatelessWidget {
  const FlappyBird({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: Image.asset(
        
        "images/flappy_bird.png",
        
      ),
    );
  }
}