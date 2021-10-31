// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:math';

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
  double birdWidth = 0.1;
  double birdHeight = 0.1;

  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6]
  ];
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

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdYAxis = 0;
      play = false;
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(
              child: Text(
                'GAME OVER',
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                      'PLAY AGAIN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  bool birdIsDead() {
    if (birdYAxis < -1 || birdYAxis > 1) {
      return true;
    }

    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdYAxis <= -1 + barrierHeight[i][0] ||
              birdYAxis + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (play) {
          return flapWings();
        } else {
          startGain();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYAxis),
                    duration: Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: FlappyBird(
                      birdHeight: birdHeight,
                      birdWidth: birdWidth,
                      birdYaxis: birdYAxis,
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
                  Barriers(
                    isThisBottomBarrier: false,
                    barrierX: barrierX[0],
                    barrierHeight: barrierHeight[0][0],
                    barrierWidth: barrierWidth,
                  ),
                  Barriers(
                    isThisBottomBarrier: true,
                    barrierX: barrierX[0],
                    barrierHeight: barrierHeight[0][1],
                    barrierWidth: barrierWidth,
                  ),
                  Barriers(
                    isThisBottomBarrier: false,
                    barrierX: barrierX[1],
                    barrierHeight: barrierHeight[1][0],
                    barrierWidth: barrierWidth,
                  ),
                  Barriers(
                    isThisBottomBarrier: true,
                    barrierX: barrierX[1],
                    barrierHeight: barrierHeight[1][1],
                    barrierWidth: barrierWidth,
                  )
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
