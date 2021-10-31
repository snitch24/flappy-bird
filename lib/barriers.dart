// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class Barriers extends StatelessWidget {
  final size;
  // ignore: use_key_in_widget_constructors
  const Barriers({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(width: 10,color: Colors.green[800]!),
        color: Colors.green,
        borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}
