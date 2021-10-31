// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class Barriers extends StatelessWidget {
  final barrierWidth;
  final barrierHeight;
  final barrierX;
  final bool isThisBottomBarrier;
  // ignore: use_key_in_widget_constructors
  const Barriers({ this.barrierWidth, this.barrierHeight, this.barrierX, required this.isThisBottomBarrier});

  @override
  Widget build(BuildContext context) {
    double x = (2*barrierX+barrierWidth)/(2-barrierWidth);
    return Container(
      alignment: Alignment(x,isThisBottomBarrier?1:-1),
      decoration: BoxDecoration(
        border: Border.all(width: 10, color: Colors.green[800]!),
        color: Colors.green,
        borderRadius: BorderRadius.circular(15),
      ),
      height: MediaQuery.of(context).size.width*barrierWidth/2 ,
      width: MediaQuery.of(context).size.height*3/4*barrierHeight/2,
    );
  }
}
