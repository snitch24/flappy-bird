// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static double birdYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  final double gravity = 9.8;
  bool play = false;
  void flapWings() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  void startGain() {
    play = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -(gravity / 2) * time * time + 2.8 * time;
      setState(() {
        birdYAxis = initialHeight - height;
      });
      if (birdYAxis > 1) {
        timer.cancel();
        play = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (play) {
                      return flapWings();
                    } else {
                      startGain();
                    }
                  },
                  child: AnimatedContainer(
                    alignment: Alignment(0, birdYAxis),
                    duration: Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: FlappyBird(),
                  ),
                ),
                Container(
                  alignment: Alignment(0, -0.4),
                  child: play
                      ? Text(" ")
                      : Text(
                          'TAP TO PLAY',
                          style: TextStyle(color: Colors.white, fontSize: 21),
                        ),
                ),
                AnimatedContainer(
                  alignment: Alignment(0,1),
                  duration: Duration(milliseconds: 0),
                    child: Barriers(
                  size: 50,
                ))
              ],
            ),
          ),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('SCORE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '0',
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'BEST',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '0',
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
